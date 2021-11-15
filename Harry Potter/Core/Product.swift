//
//  Product.swift
//  Harry Potter
//
//  Created by Fady Yecob on 13/11/2021.
//

import Foundation

struct Product: Decodable, Equatable {
    let id = UUID()
    let title: String
    let author: String?
    let imageURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case title
        case author
        case imageURL
    }
}

