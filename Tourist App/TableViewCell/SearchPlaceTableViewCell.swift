//
//  SearchPlaceTableViewCell.swift
//  Tourist App
//
//  Created by CrewPlace Enterprise on 22/09/24.
//

import UIKit

class SearchPlaceTableViewCell: UITableViewCell {
    private let placeNameView = UIView()
    
    private let placeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.text = ""
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configurePlaceNameView()
        configurePlaceNameLabel()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurePlaceNameView() {
        placeNameView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(placeNameView)
        

        placeNameView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        placeNameView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        placeNameView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        placeNameView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        placeNameView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    private func configurePlaceNameLabel() {
        placeNameView.addSubview(placeNameLabel)
        
        placeNameLabel.topAnchor.constraint(equalTo: placeNameView.topAnchor, constant: 10).isActive = true
        placeNameLabel.leadingAnchor.constraint(equalTo: placeNameView.leadingAnchor, constant: 10).isActive = true
        placeNameView.trailingAnchor.constraint(equalTo: placeNameView.trailingAnchor, constant: 10).isActive = true
    }
    
    func setPlaceName(_ placeName: String) {
        DispatchQueue.main.async {
            self.placeNameLabel.text = placeName
        }
    }
}
