//
//  StructuredFormatting.swift
//  Tourist App
//
//  Created by CrewPlace Enterprise on 22/09/24.
//

import Foundation

class StructuredFormatting: Codable {
    let mainText: String
    
    enum CodingKeys: String, CodingKey {
        case mainText = "main_text"
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mainText = try container.decode(String.self, forKey: .mainText)
    }
}
