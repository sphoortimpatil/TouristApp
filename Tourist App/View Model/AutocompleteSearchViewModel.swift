//
//  AutocompleteSearchViewModel.swift
//  Tourist App
//
//  Created by Sphoorti Patil on 22/09/24.
//

import Foundation

class AutocompleteSearchViewModel {
    func fetchAutocompleteSearchPredictions(searchString: String, completionHandler: @escaping (Result<AutocompletePredictionsList, Error>) -> Void) {
        fetchAsyncGooglePlaceApiData(url: Constants.GooglePlacesApi.autocompleteSearchApiUrl, params: searchString) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let responseData = try decoder.decode(AutocompletePredictionsList.self, from: data)
                    completionHandler(.success(responseData))
                } catch let decodingError {
                    completionHandler(.failure(decodingError))
                }
                
            case .failure(let error) :
                completionHandler(.failure(error))
            }
        }
    }
}
