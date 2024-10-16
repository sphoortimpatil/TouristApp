//
//  RatingStarView.swift
//  Tourist App
//
//  Created by Sphoorti Patil on 29/09/24.
//

import UIKit

class RatingStarView: UIView {
    private let starStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private var starImageViews: [UIImageView] = []
    
    private let ratingLabel: UILabel = {
        let ratingLabel = UILabel()
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.text = "0"
        ratingLabel.font = UIFont.systemFont(ofSize: 14)
        ratingLabel.numberOfLines = 1
        return ratingLabel
    }()
    
    private let ratingCountLabel: UILabel = {
        let ratingCountLabel = UILabel()
        ratingCountLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingCountLabel.text = "(0)"
        ratingCountLabel.font = UIFont.systemFont(ofSize: 14)
        ratingCountLabel.numberOfLines = 1
        return ratingCountLabel
    }()
    
    private var rating: Double = 0
    private let maxRating: Int = 5
    private let starSize: CGFloat = 20.0
    private let filledStarImage: UIImage? = UIImage(systemName: "star.fill")
    private let halfStarImage: UIImage? = UIImage(systemName: "star.leadinghalf.filled")
    private let emptyStarImage: UIImage? = UIImage(systemName: "star")


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureRatingLabel()
        configureStarStackView()
        configureRatingCountLabel()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureRatingLabel() {
        self.addSubview(ratingLabel)
        
        ratingLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        ratingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        ratingLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
        ratingLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        ratingLabel.text = String(rating)
    }
    
    private func configureStarStackView() {
        self.addSubview(starStackView)

        starStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        starStackView.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 5).isActive = true
        starStackView.widthAnchor.constraint(equalToConstant: (starSize * 5) ).isActive = true
        starStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        addStarts()
    }
    
    private func addStarts() {
        for _ in 0..<maxRating {
            let starImageView = UIImageView()
            starImageView.contentMode = .scaleAspectFit
            starStackView.addArrangedSubview(starImageView)
            starImageViews.append(starImageView)
        }
        configureRatingStar()
        updateStarImages()
    }
    
    private func configureRatingStar() {
        for imageView in starImageViews {
            imageView.translatesAutoresizingMaskIntoConstraints = false

            imageView.heightAnchor.constraint(equalToConstant: starSize).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: starSize).isActive = true
        }
    }
    
    private func updateStarImages() {
        for (index, starImageView) in starImageViews.enumerated() {
            if CGFloat(index) < floor(rating) {
                starImageView.image = filledStarImage
                starImageView.tintColor = .systemYellow
            } else if CGFloat(index) < rating {
                starImageView.image = halfStarImage
                starImageView.tintColor = .systemYellow
            } else {
                starImageView.image = emptyStarImage
                starImageView.tintColor = .gray
            }
        }
    }
    
    private func configureRatingCountLabel() {
        self.addSubview(ratingCountLabel)
        
        ratingCountLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        ratingCountLabel.leadingAnchor.constraint(equalTo: starStackView.trailingAnchor, constant: 5).isActive = true
        ratingCountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        ratingCountLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func setRatingData(_ rating: Double?, _ ratingCount: Int?) {
        let rating = rating ?? 0
        let ratingCount = ratingCount ?? 0
        self.rating = rating
        ratingLabel.text = String(rating)
        ratingCountLabel.text = "(\(ratingCount))"
        updateStarImages()
    }
}
