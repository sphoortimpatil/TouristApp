//
//  UIImageView+AsyncImage.swift
//  Tourist App
//
//  Created by Sphoorti Patil on 29/09/24.
//

import Foundation
import UIKit

extension UIImageView {
    func asyncLoadImage(imageUrl: String, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: imageUrl) else {
            completionHandler(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest){data, response, error in
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
}
