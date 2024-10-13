//
//  NearbyPlaceTableViewCell.swift
//  Tourist App
//
//  Created by CrewPlace Enterprise on 30/09/24.
//

import UIKit

class NearbyPlaceTableViewCell: UITableViewCell {
    private let nearbyAttractionsView = NearbyAttractionsView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureSearchedPlaceNearbyAttractionsView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSearchedPlaceNearbyAttractionsView() {
        nearbyAttractionsView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nearbyAttractionsView)
        
        nearbyAttractionsView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        nearbyAttractionsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        nearbyAttractionsView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        nearbyAttractionsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        nearbyAttractionsView.backgroundColor = .systemGray2
        nearbyAttractionsView.layer.cornerRadius = 10
    }
    
    func setNearbyPlaceCellData(_ nearbyAttractionsData: NearbyAttractionsDataModel) {
        nearbyAttractionsView.setNearbyAttractionsData(nearbyAttractionsData)
    }
}
