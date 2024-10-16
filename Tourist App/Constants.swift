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
        static let apiValue = Bundle.main.infoDictionary?["GOOGLE_PLACES_API_KEY_VALUE"] as? String ?? ""
        static let apiHostKey = "x-rapidapi-host"
        static let apiHostValue = Bundle.main.infoDictionary?["GOOGLE_PLACES_API_HOST_VALUE"] as? String ?? ""
        static let autocompleteSearchApiUrl = "https://google-map-places.p.rapidapi.com/maps/api/place/queryautocomplete/json?radius=1000&input="
        static let placeDescriptionApi = "https://google-map-places.p.rapidapi.com/maps/api/place/details/json?fields=name,geometry&place_id="
        static let nearbyPlacesAPi = "https://google-map-places.p.rapidapi.com/maps/api/place/nearbysearch/json?radius=5000&type=tourist_attraction&location="
    }
    
    struct MapsDataApi {
        static let apiKey  = "x-rapidapi-key"
        static let apiValue = Bundle.main.infoDictionary?["MAPS_DATA_API_KEY_VALUE"] as? String ?? ""
        static let apiHostKey = "x-rapidapi-host"
        static let apiHostValue = Bundle.main.infoDictionary?["MAPS_DATA_API_HOST_VALUE"] as? String ?? ""
        static let placeInfoApi = "https://maps-data.p.rapidapi.com/place.php?place_id="
        static let nearbyPlacesDataApi = "https://maps-data.p.rapidapi.com/nearby.php?query=Tourist attraction&limit=30&"
    }
    
    struct PexelApi {
        static let header = "Authorization"
        static let value = Bundle.main.infoDictionary?["PEXEL_API_KEY_VALUE"] as? String ?? ""
        static let url = "https://api.pexels.com/v1/search?per_page=20&query="
    }
}
