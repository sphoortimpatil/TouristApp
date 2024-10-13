//
//  NearbyAttractionsPhotosModel.swift
//  Tourist App
//
//  Created by CrewPlace Enterprise on 28/09/24.
//

import Foundation

class NearbyAttractionsPhotosModel: Codable {
    let src: String
    
    enum CodingKeys: String, CodingKey {
        case src
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.src = try container.decode(String.self, forKey: .src)
    }
}
