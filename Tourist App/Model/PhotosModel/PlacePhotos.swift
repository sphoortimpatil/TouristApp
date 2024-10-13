//
//  PlacePhotos.swift
//  Tourist App
//
//  Created by CrewPlace Enterprise on 06/10/24.
//

import Foundation

class PlacePhotos: Codable {
    let url: String
    let width: Int
    let height: Int
    let photographer: String
    let photographerId: Int
    let altText: String
    let imageSrc: PhotosUrl
    
    enum CodingKeys: String, CodingKey {
        case url
        case width
        case height
        case photographer
        case photographerId = "photographer_id"
        case altText = "alt"
        case imageSrc = "src"
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try container.decode(String.self, forKey: .url)
        self.width = try container.decode(Int.self, forKey: .width)
        self.height = try container.decode(Int.self, forKey: .height)
        self.photographer = try container.decode(String.self, forKey: .photographer)
        self.photographerId = try container.decode(Int.self, forKey: .photographerId)
        self.altText = try container.decode(String.self, forKey: .altText)
        self.imageSrc = try container.decode(PhotosUrl.self, forKey: .imageSrc)
    }
}
