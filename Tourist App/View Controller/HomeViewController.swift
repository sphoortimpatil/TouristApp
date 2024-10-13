//
//  HomeViewController.swift
//  Tourist App
//
//  Created by CrewPlace Enterprise on 22/09/24.
//

import UIKit

class HomeViewController: UIViewController {
    private let spinnerView = SpinnerView()
    private let searchBar = SearchBar()
    private let searchPlaceVC = SearchPlaceViewController()
    private let autocompleteVM = AutocompleteSearchViewModel()
    private let nearbyAttractionsVC = NearbyAttractionsViewController()
    private let nearbyAttractionsVM = NearbyAttractionsViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureSearchPlaceVC()
        configureSearchBar()
        configureSearchedPlaceNearbyAttractionsVC()
        configureSpinnerView()
        setDelegated()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        searchBar.setSearchInteractions(true)
    }
    
    private func configureSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.addSubview(searchBar)

        searchBar.topAnchor.constraint(equalTo: navigationBar.topAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor,constant: 10).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -10).isActive = true
        
    }
    
    private func configureSearchPlaceVC() {
        addChild(searchPlaceVC)
        guard let searchPlaceView = searchPlaceVC.view else { return }
        
        searchPlaceView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchPlaceView)
        
        searchPlaceView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchPlaceView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        searchPlaceView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchPlaceView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        searchPlaceView.isHidden = false
        searchPlaceVC.didMove(toParent: self)
    }
    
    private func configureSearchedPlaceNearbyAttractionsVC() {
        addChild(nearbyAttractionsVC)
        guard let searchedPlaceNearbyAttractionsView = nearbyAttractionsVC.view else { return }
        
        searchedPlaceNearbyAttractionsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchedPlaceNearbyAttractionsView)
        
        
        searchedPlaceNearbyAttractionsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchedPlaceNearbyAttractionsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        searchedPlaceNearbyAttractionsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchedPlaceNearbyAttractionsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        searchedPlaceNearbyAttractionsView.backgroundColor = .gray
        searchedPlaceNearbyAttractionsView.isHidden = true
        
        nearbyAttractionsVC.didMove(toParent: self)
    }
    
    private func configureSpinnerView() {
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinnerView)
        
        spinnerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinnerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setDelegated() {
        searchBar.delegate = self
        searchPlaceVC.delegate = self
        nearbyAttractionsVC.delegate = self
    }
}

extension HomeViewController: SearchBarDelegate {
    func onSearchTap(searchValue: String) {
        switch searchValue.count {
        case 0...2:
            DispatchQueue.main.async {
                self.nearbyAttractionsVC.view.isHidden = true
                self.searchPlaceVC.view.isHidden = true
            }
        default:
            DispatchQueue.main.async {
                self.nearbyAttractionsVC.view.isHidden = true
                self.searchPlaceVC.view.isHidden = false
            }
            spinnerView.setSpinnerAnimation(true)
            autocompleteVM.fetchAutocompleteSearchPredictions(searchString: searchValue) {
                result in
                switch result {
                case .success(let data):
                    self.searchPlaceVC.setAutocompleteSearchListData(data.predictions)
                    self.spinnerView.setSpinnerAnimation(false)
                case .failure(let error):
                    print(error)
                    self.spinnerView.setSpinnerAnimation(false)
                }
            }
        }
    }
}


extension HomeViewController: SearchPlaceViewControllerDelegate {
    func setSelectedSearchTextOnDidSelect(searchedString: String) {
        searchBar.setSelectedSearchText(searchedString)
    }
    
    func didTapPlaceNameToSearch(result: Result<SearchedPlaceInfoData, any Error>) {
        DispatchQueue.main.async {
            self.searchPlaceVC.view.isHidden = true
        }
        spinnerView.setSpinnerAnimation(true)
        switch result {
        case .success(let placeInfo):
            self.nearbyAttractionsVM.fetchNearbyPlaces(lat: placeInfo.latitude, lng: placeInfo.longitude) { [weak self] result in
                switch result {
                case.success(let nearbySearchedPlaceData):
                    self?.nearbyAttractionsVC.setNearbyearchedPlaceData(nearbySearchedPlaceData)
                    DispatchQueue.main.async {
                        self?.nearbyAttractionsVC.view.isHidden = false
                    }
                    self?.spinnerView.setSpinnerAnimation(false)
                case .failure(let error):
                    print("NearbyPlace Error", error)
                    self?.spinnerView.setSpinnerAnimation(false)
                }
            }
        case .failure(let error):
            print("Error", error)
            self.spinnerView.setSpinnerAnimation(false)
        }
    }
}

extension HomeViewController: NearbyAttractionsViewControllerDelegate {
    func didSelecrTouristPlace(selectedPlaceData: NearbyAttractionsDataModel) {
        let searchedPlacePhotosViewController = SearchedPlacePhotosViewController()
        searchedPlacePhotosViewController.setImageData(placeName: selectedPlaceData.name)
        searchBar.setSearchInteractions(false)
        navigationController?.pushViewController(searchedPlacePhotosViewController, animated: true)
    }
}
