//
//  NearbyAttractionsViewController.swift
//  Tourist App
//
//  Created by Sphoorti Patil on 29/09/24.
//

import UIKit

protocol NearbyAttractionsViewControllerDelegate: AnyObject {
    func didSelecrTouristPlace(selectedPlaceData: NearbyAttractionsDataModel)
}

class NearbyAttractionsViewController: UIViewController {
    weak var delegate: NearbyAttractionsViewControllerDelegate?
    private let nearbyAttractionsVM = NearbyAttractionsViewModel()
    private var nearbySearchedPlaceData: [NearbyAttractionsDataModel] = []
    private let nearbySearchedPlaceTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private let spinnerView = SpinnerView()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNearbyPlaceTableView()
        setDelegate()
        configureSpinnerView()
    }
    
    private func configureNearbyPlaceTableView() {
        view.addSubview(nearbySearchedPlaceTableView)
        
        nearbySearchedPlaceTableView.separatorStyle = .none
        nearbySearchedPlaceTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        nearbySearchedPlaceTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        nearbySearchedPlaceTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        nearbySearchedPlaceTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        nearbySearchedPlaceTableView.register(NearbyPlaceTableViewCell.self, forCellReuseIdentifier: "NearbyPlaceTableViewCell")
    }
    
    private func setDelegate() {
        nearbySearchedPlaceTableView.delegate = self
        nearbySearchedPlaceTableView.dataSource = self
    }
    
    private func configureSpinnerView() {
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinnerView)
        
        spinnerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinnerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func resetNearbySearchedPlaceTableViewData() {
        self.nearbySearchedPlaceData = []
        DispatchQueue.main.async {
            self.nearbySearchedPlaceTableView.reloadData()
        }
    }
    
    private func reloadNearbySearchedPlaceTableViewData(_ data: [NearbyAttractionsDataModel]) {
        self.nearbySearchedPlaceData = data
        DispatchQueue.main.async {
            self.nearbySearchedPlaceTableView.reloadData()
        }
        self.spinnerView.setSpinnerAnimation(false)
    }
    
    func setNearbyearchedPlaceData(result: Result<SearchedPlaceInfoData, any Error>) {
        resetNearbySearchedPlaceTableViewData()
        spinnerView.setSpinnerAnimation(true)
        switch result {
        case .success(let placeInfo):
            self.nearbyAttractionsVM.fetchNearbyPlaces(lat: placeInfo.latitude, lng: placeInfo.longitude) { [weak self] result in
                guard let self = self else {
                    return
                }
                switch result {
                case.success(let nearbySearchedPlaceData):
                    self.reloadNearbySearchedPlaceTableViewData(nearbySearchedPlaceData)
                case .failure(let error):
                    print("NearbyPlace Error", error)
                    self.reloadNearbySearchedPlaceTableViewData([])
                }
            }
        case .failure(let error):
            print("Error", error)
            self.reloadNearbySearchedPlaceTableViewData([])
        }
    }

}

extension NearbyAttractionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nearbySearchedPlaceData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = nearbySearchedPlaceTableView.dequeueReusableCell(withIdentifier: "NearbyPlaceTableViewCell", for: indexPath) as? NearbyPlaceTableViewCell else {
            return UITableViewCell(frame: .zero)
        }
        cell.setNearbyPlaceCellData(nearbySearchedPlaceData[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelecrTouristPlace(selectedPlaceData: nearbySearchedPlaceData[indexPath.row])
    }
}

extension NearbyAttractionsViewController: UITableViewDelegate {}
