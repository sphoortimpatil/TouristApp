//
//  PhotosViewModel.swift
//  Tourist App
//
//  Created by CrewPlace Enterprise on 06/10/24.
//

import Foundation

class PhotosViewModel {
    func fetchPlacePhotos(placeName: String, pageCount: Int, completionHandler: @escaping (Result<PlacePhotosList, Error>) -> Void) {
        fetchAsyncPexelApiData(url: Constants.PexelApi.url, placeName: placeName, pageCount: pageCount) {
            result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(PlacePhotosList.self, from: data)
                    completionHandler(.success(response))
                }
                catch(let error) {
                    completionHandler(.failure(error))
                    print("decoding errror")
                }
            case .failure(let error):
                print("error", error)
            }
        }
        
    }
}
