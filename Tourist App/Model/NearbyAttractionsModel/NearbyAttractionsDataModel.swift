//
//  NearbyAttractionsDataModel.swift
//  Tourist App
//
//  Created by Sphoorti Patil on 28/09/24.
//

import Foundation

class NearbyAttractionsDataModel: Codable {
    let placeId: String
    let name: String
    let city: String
    let state: String?
    let rating: Double?
    let reviewCount: Int?
    let photo: [NearbyAttractionsPhotosModel]
    
    enum CodingKeys: String, CodingKey {
        case placeId = "place_id"
        case name
        case city
        case state
        case rating
        case reviewCount = "review_count"
        case photo = "photos"
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.placeId = try container.decode(String.self, forKey: .placeId)
        self.name = try container.decode(String.self, forKey: .name)
        self.city = try container.decode(String.self, forKey: .city)
        self.state = try container.decodeIfPresent(String.self, forKey: .state)
        self.rating = try container.decodeIfPresent(Double.self, forKey: .rating)
        self.reviewCount = try container.decodeIfPresent(Int.self, forKey: .reviewCount)
        self.photo = try container.decode([NearbyAttractionsPhotosModel].self, forKey: .photo)
    }
}
