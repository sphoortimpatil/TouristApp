//
//  NearbyAttractionsModel.swift
//  Tourist App
//
//  Created by Sphoorti Patil on 28/09/24.
//

import Foundation

class NearbyAttractionsModel: Codable {
    let data: [NearbyAttractionsDataModel]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode([NearbyAttractionsDataModel].self, forKey: .data)
    }
}
