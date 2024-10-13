//
//  SearchPlaceViewController.swift
//  Tourist App
//
//  Created by CrewPlace Enterprise on 29/09/24.
//

import UIKit

protocol SearchPlaceViewControllerDelegate: AnyObject {
    func didTapPlaceNameToSearch(result: Result<SearchedPlaceInfoData, Error>)
    func setSelectedSearchTextOnDidSelect(searchedString: String)
}

class SearchPlaceViewController: UIViewController {
    weak var delegate: SearchPlaceViewControllerDelegate?
    
    private let spinnerView = SpinnerView()
    private var autocomopltedSearchList: [AutocompletePredictions] = []
    private let searchedPlaceInfoVM = SearchedPlaceInfoViewModel()
    private let searchedPlaceNearbyAttractionsVM = NearbyAttractionsViewModel()
    
    private let searchPlaceTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSpinnerView()
        configureTableView()
        setDelegated()
    }

    private func configureSpinnerView() {
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinnerView)
        
        spinnerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinnerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func configureTableView() {
        view.addSubview(searchPlaceTableView)
        
        searchPlaceTableView.separatorStyle = .none
        searchPlaceTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        searchPlaceTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        searchPlaceTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchPlaceTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        searchPlaceTableView.register(SearchPlaceTableViewCell.self, forCellReuseIdentifier: "SearchPlaceTableViewCell")
    }
    
    private func setDelegated() {
        searchPlaceTableView.dataSource = self
        searchPlaceTableView.delegate = self
    }
    
    func setAutocompleteSearchListData(_ autocomopltedSearchList: [AutocompletePredictions] ) {
        self.autocomopltedSearchList = autocomopltedSearchList
        DispatchQueue.main.async {
            self.searchPlaceTableView.isHidden = false
            self.searchPlaceTableView.separatorStyle = .none
            self.searchPlaceTableView.reloadData()
        }
    }
}

extension SearchPlaceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        autocomopltedSearchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchPlaceTableView.dequeueReusableCell(withIdentifier: "SearchPlaceTableViewCell", for: indexPath) as? SearchPlaceTableViewCell else {
            return UITableViewCell(frame: .zero)
        }
        cell.setPlaceName(autocomopltedSearchList[indexPath.row].structuredFormatting.mainText)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchedText = autocomopltedSearchList[indexPath.row].structuredFormatting.mainText
        self.delegate?.setSelectedSearchTextOnDidSelect(searchedString: searchedText)
        spinnerView.setSpinnerAnimation(true)
        DispatchQueue.main.async {
            self.searchPlaceTableView.isHidden = true
        }
        let placeId = autocomopltedSearchList[indexPath.row].placeId
        searchedPlaceInfoVM.fetchSearchedPlaceInfo(placeId: placeId) {
            result in
            switch result{
            case .success(let placeInfo):
                self.delegate?.didTapPlaceNameToSearch(result: .success(placeInfo))
                self.spinnerView.setSpinnerAnimation(false)
            case .failure(let error):
                self.spinnerView.setSpinnerAnimation(false)
                self.delegate?.didTapPlaceNameToSearch(result: .failure(error))
            }
        }
    }
    
}

extension SearchPlaceViewController: UITableViewDelegate {}
