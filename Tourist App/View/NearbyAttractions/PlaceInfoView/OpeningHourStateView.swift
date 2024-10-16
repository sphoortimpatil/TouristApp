//
//  OpeningHourStateView.swift
//  Tourist App
//
//  Created by Sphoorti Patil on 30/09/24.
//

import UIKit

class OpeningHourStateView: UIView {
    private let stateLabel: UILabel = {
        let stateLabel = UILabel()
        stateLabel.translatesAutoresizingMaskIntoConstraints = false
        stateLabel.text = "Closes soon "
        stateLabel.font = UIFont.boldSystemFont(ofSize: 14)
        stateLabel.numberOfLines = 1
        return stateLabel
    }()
    private let closingTimeLabel: UILabel = {
        let closingTimeLabel = UILabel()
        closingTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        closingTimeLabel.text = ""
        closingTimeLabel.font = UIFont.systemFont(ofSize: 14)
        closingTimeLabel.numberOfLines = 1
        closingTimeLabel.textColor = .systemGray
        return closingTimeLabel
    }()
    private let stateTimeChangeLabel: UILabel = {
        let stateChangeTimeLabel = UILabel()
        stateChangeTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        stateChangeTimeLabel.text = ""
        stateChangeTimeLabel.font = UIFont.systemFont(ofSize: 14)
        stateChangeTimeLabel.numberOfLines = 1
        stateChangeTimeLabel.textColor = .systemGray
        return stateChangeTimeLabel
    }()
    private var openState: String = ""

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureStateDetailsLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureStateDetailsLabel() {
        self.addSubview(stateLabel)
        
        stateLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        
        self.addSubview(closingTimeLabel)
        
        closingTimeLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        closingTimeLabel.leadingAnchor.constraint(equalTo: stateLabel.trailingAnchor, constant: 5).isActive = true
        
        
        self.addSubview(stateTimeChangeLabel)
        
        stateTimeChangeLabel.topAnchor.constraint(equalTo: stateLabel.bottomAnchor).isActive = true
        stateTimeChangeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }
    
    private func setStateLabelTextColor() {
        var stateLabelColor: UIColor = .systemGray
        switch openState {
        case "Open": stateLabelColor = .systemGreen
        case "Open 24 hours": stateLabelColor = .systemGreen
        case "Closed": stateLabelColor = .systemRed
        case "Closes soon": stateLabelColor = .systemYellow
        case "Opens Soon": stateLabelColor = .systemYellow
        default: stateLabelColor = .systemGray
        }
        stateLabel.textColor = stateLabelColor
    }
    
    func setOpeningHourStateLabels(_ openingHourState: String?) {
        guard let openingHourState = openingHourState else {
            openState = "Unknown Timings"
            stateLabel.text = openState
            closingTimeLabel.text = ""
            stateTimeChangeLabel.text = ""
            setStateLabelTextColor()
            return
        }
        let splitOpeningHourState = openingHourState.split(separator: "⋅")
        openState = String(splitOpeningHourState.first ?? "").trimmingCharacters(in: .whitespaces)
        stateLabel.text = openState
        stateTimeChangeLabel.text = splitOpeningHourState.count == 2 ? String(splitOpeningHourState.last ?? "").trimmingCharacters(in: .whitespaces) : ""
        closingTimeLabel.text = splitOpeningHourState.count == 3 ? String(splitOpeningHourState[1].trimmingCharacters(in: .whitespaces)) : ""
        setStateLabelTextColor()
    }
}
