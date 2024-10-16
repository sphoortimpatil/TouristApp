//
//  NoResultsFoundView.swift
//  Tourist App
//
//  Created by Sphoorti Patil on 13/10/24.
//

import UIKit

class NoResultsFoundView: UIView {
    private let noResultsFoundTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No Results Found"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private let noResultsFoundDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "There were no results for Searched Place. Try a different place"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLabel() {
        self.addSubview(noResultsFoundTitleLabel)
        
        noResultsFoundTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
        noResultsFoundTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        noResultsFoundTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        
        
        self.addSubview(noResultsFoundDescriptionLabel)
        
        noResultsFoundDescriptionLabel.topAnchor.constraint(equalTo: noResultsFoundTitleLabel.bottomAnchor, constant: 10).isActive = true
        noResultsFoundDescriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        noResultsFoundDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
    }
}
