//
//  CatalogApiModel.swift
//  yourProjectName
//
//  Created by Grigoriy on 04.12.2023.
//

import Foundation

struct CatalogApiModel: Codable {
    let type: String
    let description: String
    let price: String
    let status: String
    var image_url_after_serializer: String
}
