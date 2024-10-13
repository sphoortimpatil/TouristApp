//
//  SearchBar.swift
//  Tourist App
//
//  Created by CrewPlace Enterprise on 22/09/24.
//

protocol SearchBarDelegate: AnyObject {
    func onSearchTap(searchValue: String)
}

import UIKit

class SearchBar: UIView {
    weak var delegate: SearchBarDelegate?
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Enter Place to search"
        searchBar.searchBarStyle = .minimal
        searchBar.returnKeyType = .search
        searchBar.keyboardType = .default
        searchBar.becomeFirstResponder()
        return searchBar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSearchBar()
        configureDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSearchBar() {
        self.addSubview(searchBar)
        
        searchBar.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func configureDelegate() {
        searchBar.delegate = self
    }
    
    func setSelectedSearchText(_ selectedSearchText: String) {
        searchBar.text = selectedSearchText
        searchBar.resignFirstResponder()
    }
    
    func setSearchInteractions(_ isEnabled: Bool) {
        searchBar.searchTextField.isEnabled = isEnabled
    }
}

extension SearchBar: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.onSearchTap(searchValue: searchText)
    }
}
