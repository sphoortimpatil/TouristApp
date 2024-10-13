//
//  SearchedPlaceInfoModel.swift
//  Tourist App
//
//  Created by CrewPlace Enterprise on 28/09/24.
//

import Foundation

class SearchedPlaceInfoModel: Codable{
    let data: [SearchedPlaceInfoData]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode([SearchedPlaceInfoData].self, forKey: .data)
    }
}
