//
//  SearchedPlaceInfoData.swift
//  Tourist App
//
//  Created by Sphoorti Patil on 28/09/24.
//

import Foundation

class SearchedPlaceInfoData: Codable {
    let latitude: Double
    let longitude: Double
    let businessId: String
    let placeId: String
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case businessId = "business_id"
        case placeId = "place_id"
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        self.businessId = try container.decode(String.self, forKey: .businessId)
        self.placeId = try container.decode(String.self, forKey: .placeId)
    }
}
