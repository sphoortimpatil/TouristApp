//
//  PlacePhotosList.swift
//  Tourist App
//
//  Created by CrewPlace Enterprise on 06/10/24.
//

import Foundation

class PlacePhotosList: Codable {
   var photosList: [PlacePhotos]
   
   enum CodingKeys: String, CodingKey {
       case photosList = "photos"
   }
   
   required init(from decoder: any Decoder) throws {
       let container = try decoder.container(keyedBy: CodingKeys.self)
       self.photosList = try container.decode([PlacePhotos].self, forKey: .photosList)
   }
}
