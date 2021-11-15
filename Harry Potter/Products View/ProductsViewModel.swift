//
//  ProductsViewModel.swift
//  Harry Potter
//
//  Created by Fady Yecob on 13/11/2021.
//

import Foundation

class ProductsViewModel {
    private let productsRepository: ProductsRepository
    private let productFavoritesRepository: ProductFavoritesRepository
    
    lazy var products: [ProductItemViewModel] = {
        productsRepository.fetchProducts().map {
            ProductItemViewModel(product: $0, productFavoritesRepository: productFavoritesRepository)
        }
    }()
    
    init(productsRepository: ProductsRepository, productFavoritesRepository: ProductFavoritesRepository) {
        self.productsRepository = productsRepository
        self.productFavoritesRepository = productFavoritesRepository
    }
    
}
