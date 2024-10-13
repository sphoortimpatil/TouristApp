//
//  NearbyAttractionsView.swift
//  Tourist App
//
//  Created by CrewPlace Enterprise on 28/09/24.
//

import UIKit

class NearbyAttractionsView: UIView {
    private let nearbyAttractionsImageView = CustomImageView()
    private let placeInfoView = PlaceInfoView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSearchedPlaceImageView()
        configurePlaceInfoView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSearchedPlaceImageView() {
        nearbyAttractionsImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nearbyAttractionsImageView)
        
        nearbyAttractionsImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        nearbyAttractionsImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        nearbyAttractionsImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        nearbyAttractionsImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 3 / 8, constant: -10).isActive = true
    }
    
    private func configurePlaceInfoView() {
        placeInfoView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(placeInfoView)
        
        placeInfoView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        placeInfoView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 7 / 8).isActive = true
        placeInfoView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 5 / 8, constant: -15).isActive = true
        placeInfoView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        placeInfoView.backgroundColor = .white
        placeInfoView.layer.cornerRadius = 10
    }
    
    func setNearbyAttractionsData(_ nearbyAttractionsData: NearbyAttractionsDataModel) {
        placeInfoView.setPlaceInfoData(nearbyAttractionsData)
        let imageUrl = nearbyAttractionsData.photo.last?.src ?? ""
        nearbyAttractionsImageView.setImage(imageUrl)
    }
}
