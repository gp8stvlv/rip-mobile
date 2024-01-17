//
//  CatalogService.swift
//  yourProjectName
//
//  Created by Grigoriy on 04.12.2023.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case emptyData
}
final class CatalogService {
    private init() {}
    static let shared = CatalogService()

    func getCatalogData(with albumNumber: String?, price: String?, completion: @escaping (Result<[CatalogApiModel], Error>) -> Void) {
        var urlString = "http:/192.168.0.62/equipment/"
   
        
        if let albumNumber = albumNumber {
            urlString += "?type=\(albumNumber)"
        }

        if let price = price {
            urlString += "&price=\(price)"
        }
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            if let error = error {
                print("error")
                completion(.failure(error))
            }
            guard let data = data else {
                completion(.failure(NetworkError.emptyData))
                return
            }

            do {
                let catalogData = try JSONDecoder().decode([CatalogApiModel].self, from: data)
                completion(.success(catalogData))
            } catch let error {
                completion(.failure(error))
            }
        }).resume()
    }
}
