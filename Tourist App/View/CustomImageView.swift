//
//  CustomImageView.swift
//  Tourist App
//
//  Created by CrewPlace Enterprise on 05/10/24.
//

import UIKit

class CustomImageView: UIView {
    private var imageUrl: String = ""
    private let placeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ImagePlaceHolder")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let spinnerView = SpinnerView()
    
    let reloadButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        let reloadIcon = UIImage(systemName: "arrow.clockwise")
        button.tintColor = .systemIndigo
        button.setImage(reloadIcon, for: .normal)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configurePlaceImageView()
        configureSpinnerView()
        configureReloadButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurePlaceImageView() {
        self.addSubview(placeImageView)
        
        placeImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        placeImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        placeImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        placeImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func configureSpinnerView() {
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        placeImageView.addSubview(spinnerView)
        
        spinnerView.centerXAnchor.constraint(equalTo: placeImageView.centerXAnchor).isActive = true
        spinnerView.bottomAnchor.constraint(equalTo: placeImageView.bottomAnchor, constant: -20).isActive = true
    }
    
    private func configureReloadButton() {
        placeImageView.addSubview(reloadButton)
        
        reloadButton.topAnchor.constraint(equalTo: placeImageView.topAnchor, constant: 5).isActive = true
        reloadButton.trailingAnchor.constraint(equalTo: placeImageView.trailingAnchor, constant: -5).isActive = true
        reloadButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        reloadButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        reloadButton.isHidden = true
        
        placeImageView.isUserInteractionEnabled = true
        reloadButton.addTarget(self, action: #selector(self.reloadButtonClick(_:)), for: .touchUpInside)
    }
    
    @objc func reloadButtonClick(_ sender: UIButton) {
            reloadButton.isHidden = false
            setImage(self.imageUrl)
       }

    func setImage(_ imageUrl: String) {
        self.imageUrl = imageUrl
        spinnerView.setSpinnerAnimation(true)
        placeImageView.image = UIImage(named: "ImagePlaceHolder")
        placeImageView.asyncLoadImage(imageUrl: imageUrl) {
            result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.placeImageView.image = UIImage(data: data)
                    self.reloadButton.isHidden = true
                }
                self.spinnerView.setSpinnerAnimation(false)
            case .failure(let error):
                print("Error in loading Image", error)
                self.spinnerView.setSpinnerAnimation(false)
                DispatchQueue.main.async {
                    self.reloadButton.isHidden = false
                }
            }
        }
    }
    
}
