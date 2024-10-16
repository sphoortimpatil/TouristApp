//
//  AutocompletePredictions.swift
//  Tourist App
//
//  Created by Sphoorti Patil on 22/09/24.
//

import Foundation

class AutocompletePredictions: Codable {
    let placeId : String
    let structuredFormatting : StructuredFormatting
    
    enum CodingKeys: String, CodingKey {
        case placeId = "place_id"
        case structuredFormatting = "structured_formatting"
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.placeId = try container.decode(String.self, forKey: .placeId)
        self.structuredFormatting = try container.decode(StructuredFormatting.self, forKey: .structuredFormatting)
    }
}

