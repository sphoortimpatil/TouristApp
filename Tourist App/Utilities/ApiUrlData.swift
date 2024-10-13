//
//  ApiUrlData.swift
//  Tourist App
//
//  Created by CrewPlace Enterprise on 22/09/24.
//

import Foundation

func fetchAsyncGooglePlaceApiData(url: String, params: String, completionHandler: @escaping (Result<Data, Error>) -> Void) {
    guard let url = URL(string:  url + params) else {
        completionHandler(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
        return
    }
    var request = URLRequest(url: url)
    request.setValue(Constants.GooglePlacesApi.apiValue, forHTTPHeaderField: Constants.GooglePlacesApi.apiKey)
    request.setValue(Constants.GooglePlacesApi.apiHostValue, forHTTPHeaderField: Constants.GooglePlacesApi.apiHostKey)
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completionHandler(.failure(error))
            return
        }
        
        guard let data = data else {
            completionHandler(.failure(NSError(domain: "No Data", code: 500, userInfo: nil)))
            return
        }

        completionHandler(.success(data))
    }.resume()
    
}

func fetchAsyncRapidApiMapsData(url: String, params: String, completionHandler: @escaping (Result<Data, Error>) -> Void) {
    guard let url = URL(string:  url + params) else {
        completionHandler(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
        return
    }
    var request = URLRequest(url: url)
    request.setValue(Constants.MapsDataApi.apiValue, forHTTPHeaderField: Constants.MapsDataApi.apiKey)
    request.setValue(Constants.MapsDataApi.apiHostValue, forHTTPHeaderField: Constants.MapsDataApi.apiHostKey)
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completionHandler(.failure(error))
            return
        }
        
        guard let data = data else {
            completionHandler(.failure(NSError(domain: "No Data", code: 500, userInfo: nil)))
            return
        }

        completionHandler(.success(data))
    }.resume()
    
}

func fetchAsyncPexelApiData(url: String, placeName: String, pageCount: Int, completionHandler: @escaping (Result<Data, Error>) -> Void) {
    let params = "\(placeName)&page=\(pageCount)"
    guard let url = URL(string: url + params) else {
        completionHandler(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
        return
    }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.addValue(Constants.PexelApi.value, forHTTPHeaderField: Constants.PexelApi.header)
    
    URLSession.shared.dataTask(with: urlRequest) { data, response, error in
        if let error = error {
            completionHandler(.failure(error))
            return
        }
        
        guard let data = data else {
            completionHandler(.failure(NSError(domain: "No Data", code: 500, userInfo: nil)))
            return
        }
        
        completionHandler(.success(data))
        
    }.resume()
}
