//
//  SearchedPlacePhotosViewController.swift
//  Tourist App
//
//  Created by Sphoorti Patil on 05/10/24.
//

import UIKit

class SearchedPlacePhotosViewController: UIViewController {
    
    private let searchedPlacePhotosCollectionView: UICollectionView = {
        let layout: PinterestLayout = PinterestLayout()
        let collectionView = UICollectionView(frame:.zero , collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    private let noResultsFoundView = NoResultsFoundView()
    private let spinnerView = SpinnerView()
    private var placeName: String = ""
    private var photosViewModel = PhotosViewModel()
    private var placePhotosList: [PlacePhotos] = []
    private let maxHeightAllowed: CGFloat = 200
    private var maxOriginalHeight: Int = 5000
    
    private var currentPage = 1
    private var totalPages = 10
    private var isEndOfData = false
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavBar()
        configureGestureNavigation()
        configureSearchedPlacePhotosCollectionView()
        setUpDelegate()
        configureNoResultsFoundView()
        configureSpinnerView()
        configureRefreshControl()
    }
    
    private func configureNavBar() {
        view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.hidesBackButton = true
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = .black
    }
    
    private func configureGestureNavigation() {
        let backGesture = UISwipeGestureRecognizer(target: self , action: #selector(onBackGesture))
        backGesture.direction = .right
        self.view.addGestureRecognizer(backGesture)
    }
    
    @objc func onBackGesture(_ sender: UISwipeGestureRecognizer) {
        if (sender.state == .ended ) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func configureSearchedPlacePhotosCollectionView() {
        view.addSubview(searchedPlacePhotosCollectionView)
        
        searchedPlacePhotosCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchedPlacePhotosCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        searchedPlacePhotosCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchedPlacePhotosCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        searchedPlacePhotosCollectionView.register(SearchedPlacePhotosCollectionViewCell.self, forCellWithReuseIdentifier: "SearchedPlacePhotosCell")
    }
        
    private func setUpDelegate() {
        searchedPlacePhotosCollectionView.dataSource = self
        searchedPlacePhotosCollectionView.delegate = self
        
        if let layout = searchedPlacePhotosCollectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
    }
    
    private func configureNoResultsFoundView() {
        noResultsFoundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noResultsFoundView)
        
        noResultsFoundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        noResultsFoundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        noResultsFoundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        noResultsFoundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        noResultsFoundView.isHidden = true
    }
    
    private func configureSpinnerView() {
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinnerView)
        
        spinnerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinnerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        spinnerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        spinnerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        spinnerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        spinnerView.isHidden = true
    }
    
    private func configureRefreshControl() {
           refreshControl.addTarget(self, action: #selector(loadImageData), for: .valueChanged)
        searchedPlacePhotosCollectionView.refreshControl = refreshControl
       }
    
    private func reloadColelctionViewData(_ photosList: [PlacePhotos]) {
        switch photosList.count{
        case 0:
            self.isEndOfData = true
            if(self.placePhotosList.count == 0) {
                DispatchQueue.main.async {
                    self.noResultsFoundView.isHidden = false
                    self.searchedPlacePhotosCollectionView.isHidden = true
                }
            }
        default:
            self.placePhotosList += photosList
            DispatchQueue.main.async {
                self.searchedPlacePhotosCollectionView.reloadData()
            }
        }
    }
    
    private func setSpinnerVisibilityAsHidden(_ isNotVisible: Bool) {
        self.spinnerView.setSpinnerAnimation(!isNotVisible)
        DispatchQueue.main.async {
            self.spinnerView.isHidden = isNotVisible
            self.refreshControl.endRefreshing()
        }
    }
    
    @objc private func loadImageData() {
        currentPage += 1
        setSpinnerVisibilityAsHidden(false)
        setImageData(placeName: self.placeName)
    }
    
    func setImageData(placeName: String) {
        self.placeName = placeName
        self.setSpinnerVisibilityAsHidden(false)
        photosViewModel.fetchPlacePhotos(placeName: placeName, pageCount: currentPage) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let photosList):
                self.setSpinnerVisibilityAsHidden(true)
                self.reloadColelctionViewData(photosList.photosList)
            case .failure(let error):
                print("error", error)
                self.setSpinnerVisibilityAsHidden(true)
            }
        }
    }
}

extension SearchedPlacePhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return placePhotosList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = searchedPlacePhotosCollectionView.dequeueReusableCell(withReuseIdentifier: "SearchedPlacePhotosCell", for: indexPath) as? SearchedPlacePhotosCollectionViewCell else {
            return UICollectionViewCell(frame: .zero)
        }
        cell.setImageUrl(placePhotosList[indexPath.row].imageSrc.mediumUrl)
        return cell
    }
}

extension SearchedPlacePhotosViewController: UICollectionViewDelegate {}

extension SearchedPlacePhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout , sizeForItemAt indexPath: IndexPath)->CGSize {
        let itemSize = (searchedPlacePhotosCollectionView.frame.width - (searchedPlacePhotosCollectionView.contentInset.left + searchedPlacePhotosCollectionView.contentInset.right + 10) ) / 2
               return CGSize(width: itemSize, height: itemSize)
        }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let dataCount = placePhotosList.count
        if indexPath.row == dataCount - 1, currentPage < totalPages, !isEndOfData {
            loadImageData()
        }
    }
}

extension SearchedPlacePhotosViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let photoDetail = placePhotosList[indexPath.row]
        let scalingFactor = maxHeightAllowed / CGFloat(maxOriginalHeight)
        let scaledHeight = CGFloat(photoDetail.height) * scalingFactor
        
        return scaledHeight
    }
}
