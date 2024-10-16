//
//  PlaceNameDetailsView.swift
//  Tourist App
//
//  Created by Sphoorti Patil on 30/09/24.
//

import UIKit

class PlaceNameDetailsView: UIView {
    private let placeNameLabel: UILabel = {
        let placeName = UILabel()
        placeName.translatesAutoresizingMaskIntoConstraints = false
        placeName.text = "Place Name"
        placeName.font = UIFont.boldSystemFont(ofSize: 18)
        placeName.numberOfLines = 2
        return placeName
    }()
    private let placeCityLabel: UILabel = {
        let placeCity = UILabel()
        placeCity.translatesAutoresizingMaskIntoConstraints = false
        placeCity.text = "City Name"
        placeCity.font = UIFont.italicSystemFont(ofSize: 16)
        placeCity.numberOfLines = 2
        return placeCity
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configurePlaceDetailsLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurePlaceDetailsLabel() {
        self.addSubview(placeNameLabel)
        
        placeNameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        placeNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        placeNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        
        self.addSubview(placeCityLabel)
        
        placeCityLabel.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: 5).isActive = true
        placeCityLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        placeCityLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    func setPlaceNameDetailsData(placeName: String, cityName: String) {
        placeNameLabel.text = placeName
        placeCityLabel.text = cityName
    }
}
