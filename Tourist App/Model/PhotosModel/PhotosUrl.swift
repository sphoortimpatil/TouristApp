//
//  PhotosUrl.swift
//  Tourist App
//
//  Created by Sphoorti Patil on 06/10/24.
//

import Foundation

class PhotosUrl: Codable {
   let mediumUrl: String
   
   enum CodingKeys: String, CodingKey {
       case mediumUrl = "medium"
   }
   
   required init(from decoder: any Decoder) throws {
       let container = try decoder.container(keyedBy: CodingKeys.self)
       self.mediumUrl = try container.decode(String.self, forKey: .mediumUrl)
   }
}
