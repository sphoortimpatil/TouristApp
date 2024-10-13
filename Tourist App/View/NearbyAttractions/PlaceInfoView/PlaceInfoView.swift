//
//  PlaceInfoView.swift
//  Tourist App
//
//  Created by CrewPlace Enterprise on 29/09/24.
//

import UIKit

class PlaceInfoView: UIView {
    private let placeNameDetailsView = PlaceNameDetailsView()
    
    
    private let openingHourStateView = OpeningHourStateView()

    private let ratingStarView = RatingStarView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.alpha = 0.8
        
        configurePlaceInfoView()
        configureStatusView()
        configureRatingStarView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurePlaceInfoView() {
        placeNameDetailsView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(placeNameDetailsView)
        
        placeNameDetailsView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        placeNameDetailsView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        placeNameDetailsView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        placeNameDetailsView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
    }
    
    private func configureStatusView() {
        openingHourStateView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(openingHourStateView)
        
        openingHourStateView.topAnchor.constraint(equalTo: placeNameDetailsView.bottomAnchor, constant: 10).isActive = true
        openingHourStateView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        openingHourStateView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        openingHourStateView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
    }
    
    private func configureRatingStarView() {
        ratingStarView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(ratingStarView)
        
        ratingStarView.topAnchor.constraint(equalTo: openingHourStateView.bottomAnchor, constant: 5).isActive = true
        ratingStarView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        ratingStarView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        ratingStarView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
    }
    
    func setPlaceInfoData(_ nearbyAttractionsData: NearbyAttractionsDataModel) {
        placeNameDetailsView.setPlaceNameDetailsData(placeName: nearbyAttractionsData.name, cityName: nearbyAttractionsData.city)
        openingHourStateView.setOpeningHourStateLabels(nearbyAttractionsData.state)
        ratingStarView.setRatingData(nearbyAttractionsData.rating, nearbyAttractionsData.reviewCount)
    }
}
