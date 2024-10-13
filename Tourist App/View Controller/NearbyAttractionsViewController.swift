//
//  NearbyAttractionsViewController.swift
//  Tourist App
//
//  Created by CrewPlace Enterprise on 29/09/24.
//

import UIKit

protocol NearbyAttractionsViewControllerDelegate: AnyObject {
    func didSelecrTouristPlace(selectedPlaceData: NearbyAttractionsDataModel)
}

class NearbyAttractionsViewController: UIViewController {
//    let searchedPlaceNearbyAttractionsView = SearchedPlaceNearbyAttractionsView()
    weak var delegate: NearbyAttractionsViewControllerDelegate?
    private var nearbySearchedPlaceData: [NearbyAttractionsDataModel] = []
    private let nearbySearchedPlaceTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNearbyPlaceTableView()
        setDelegate()
        
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
    
    func setNearbyearchedPlaceData(_ nearbySearchedPlaceData: [NearbyAttractionsDataModel]) {
        self.nearbySearchedPlaceData = nearbySearchedPlaceData
        DispatchQueue.main.async {
            self.nearbySearchedPlaceTableView.reloadData()
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
