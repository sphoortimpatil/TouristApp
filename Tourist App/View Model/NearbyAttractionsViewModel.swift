//
//  NearbyAttractionsViewModel.swift
//  Tourist App
//
//  Created by CrewPlace Enterprise on 28/09/24.
//

import Foundation

class NearbyAttractionsViewModel {
    func fetchNearbyPlaces(lat: Double, lng: Double, completionHandler: @escaping(Result<[NearbyAttractionsDataModel], Error>) -> Void) {
        let paramsString = "lat=\(lat)&lng=\(lng)"
        fetchAsyncRapidApiMapsData(url: Constants.MapsDataApi.nearbyPlacesDataApi, params: paramsString) {
            result in
            switch result{
            case .success(let data):
                do{
                    let decoder = JSONDecoder()
                    let responseData = try decoder.decode(NearbyAttractionsModel.self, from: data)
                    completionHandler(.success(responseData.data))
                }
                catch let decodingError {
                    completionHandler(.failure(decodingError))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
