//
//  AutocompletePredictionsList.swift
//  Tourist App
//
//  Created by Sphoorti Patil on 22/09/24.
//

import Foundation

class AutocompletePredictionsList: Codable {
    let predictions: [AutocompletePredictions]
    
    enum CodingKeys: CodingKey {
        case predictions
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.predictions = try container.decode([AutocompletePredictions].self, forKey: .predictions)
    }
}
