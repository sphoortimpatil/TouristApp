//
//  SearchedPlaceInfoViewModel.swift
//  Tourist App
//
//  Created by Sphoorti Patilon 28/09/24.
//

import Foundation

class SearchedPlaceInfoViewModel {
    
    func fetchSearchedPlaceInfo(placeId: String, completionHandler: @escaping(Result<SearchedPlaceInfoData, Error>) -> Void) {
        fetchAsyncRapidApiMapsData(url: Constants.MapsDataApi.placeInfoApi, params: placeId) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let responseData = try decoder.decode(SearchedPlaceInfoModel.self, from: data)
                    guard let placeInfo = responseData.data.first  else {
                        return completionHandler(.failure(NSError(domain: "Place Info Data not Found", code: 500, userInfo: nil)))
                    }
                    completionHandler(.success(placeInfo))
                } catch let decodingError {
                    completionHandler(.failure(decodingError))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
