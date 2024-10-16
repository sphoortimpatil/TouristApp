//
//  SpinnerView.swift
//  Tourist App
//
//  Created by Sphoorti Patil on 29/09/24.
//

import UIKit

class SpinnerView: UIView {
    private let spinnerView: UIActivityIndicatorView = {
        let spinnerIndicator = UIActivityIndicatorView(style: .medium)
        spinnerIndicator.translatesAutoresizingMaskIntoConstraints = false
        spinnerIndicator.color = .gray
        return spinnerIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSpinnerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSpinnerView() {
        self.addSubview(spinnerView)
        
        spinnerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        spinnerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func setSpinnerAnimation(_ shouldAnimate: Bool) {
        switch shouldAnimate {
        case true:
            DispatchQueue.main.async {
                self.spinnerView.startAnimating()
            }
        case false:
            DispatchQueue.main.async {
                self.spinnerView.stopAnimating()
            }
        }
    }
}
