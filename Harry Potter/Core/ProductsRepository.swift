//
//  ProductsRepository.swift
//  Harry Potter
//
//  Created by Fady Yecob on 13/11/2021.
//

import Foundation

class ProductsRepository {
    private let bundle = Bundle.main
    private let jsonDecoder = JSONDecoder()
    
    func fetchProducts() -> [Product] {
        guard
            let productsPath = bundle.path(forResource: "products", ofType: "json"),
            let productsJSON = try? String(contentsOfFile: productsPath).data(using: .utf8) else {
            return []
        }
        
        return (try? jsonDecoder.decode([Product].self, from: productsJSON)) ?? []
    }
}
