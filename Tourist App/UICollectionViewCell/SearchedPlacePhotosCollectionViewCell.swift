//
//  SearchedPlacePhotosCollectionViewCell.swift
//  Tourist App
//
//  Created by CrewPlace Enterprise on 05/10/24.
//

import UIKit

class SearchedPlacePhotosCollectionViewCell: UICollectionViewCell {
    
    private let photosView = CustomImageView()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configurePhotoView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurePhotoView() {
        photosView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(photosView)
                
        photosView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        photosView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        photosView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        photosView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
    func setImageUrl(_ imageUrl: String) {
        photosView.setImage(imageUrl)
    }
}
