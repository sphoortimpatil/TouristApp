//
//  CustomNavigationController.swift
//  Tourist App
//
//  Created by Sphoorti Patil on 04/10/24.
//

import UIKit

class CustomNavigationController: UINavigationController {
    
    static let shared : CustomNavigationController = CustomNavigationController()
    private let searchBar = SearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    private func setupNavigationBar(){
        self.navigationBar.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false


        searchBar.topAnchor.constraint(equalTo: self.navigationBar.topAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: self.navigationBar.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: self.navigationBar.trailingAnchor).isActive = true
    }
}
