//
//  Constants.swift
//  Tourist App
//
//  Created by Sphoorti Patil on 22/09/24.
//

import Foundation

struct Constants  {
    struct GooglePlacesApi {
        static let apiKey  = "x-rapidapi-key"
        static let apiValue = "d1b1896469msh85c2ec2bc978d3ep1ada6bjsn86a5d2953bf6"
        static let apiHostKey = "x-rapidapi-host"
        static let apiHostValue = "google-map-places.p.rapidapi.com"
        static let autocompleteSearchApiUrl = "https://google-map-places.p.rapidapi.com/maps/api/place/queryautocomplete/json?radius=1000&input="
        static let placeDescriptionApi = "https://google-map-places.p.rapidapi.com/maps/api/place/details/json?fields=name,geometry&place_id="
        static let nearbyPlacesAPi = "https://google-map-places.p.rapidapi.com/maps/api/place/nearbysearch/json?radius=5000&type=tourist_attraction&location="
    }
    
    struct MapsDataApi {
        static let apiKey  = "x-rapidapi-key"
        static let apiValue = "d1b1896469msh85c2ec2bc978d3ep1ada6bjsn86a5d2953bf6"
        static let apiHostKey = "x-rapidapi-host"
        static let apiHostValue = "maps-data.p.rapidapi.com"
        static let placeInfoApi = "https://maps-data.p.rapidapi.com/place.php?place_id="
        static let nearbyPlacesDataApi = "https://maps-data.p.rapidapi.com/nearby.php?query=Tourist attraction&limit=30&"
    }
    
    struct PexelApi {
        static let header = "Authorization"
        static let value = "JAE9pM4hfeoI3B6cXTfVFtpSkvFq3tDNdA9g0EURAvEpbc1QUG6XHR7R"
        static let url = "https://api.pexels.com/v1/search?per_page=20&query="
    }
}
