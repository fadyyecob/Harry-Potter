//
//  ProductItemViewModel.swift
//  Harry Potter
//
//  Created by Fady Yecob on 13/11/2021.
//

import SwiftUI
import Combine

class ProductItemViewModel: ObservableObject {
    private let id: UUID
    private var cancellables = Set<AnyCancellable>()
    let title: String
    let subtitle: String?
    let imageURL: URL?
    
    @Published var isFavorited: Bool
    
    init(product: Product, productFavoritesRepository: ProductFavoritesRepository) {
        id = product.id
        title = product.title
        subtitle = product.author
        imageURL = product.imageURL
        
        isFavorited = productFavoritesRepository.isFavorited(id: product.id)
        $isFavorited.sink {
            $0 ? productFavoritesRepository.addToFavorites(id: product.id) : productFavoritesRepository.removeFromFavorites(id: product.id)
        }.store(in: &cancellables)
    }

}

extension ProductItemViewModel: Hashable {
    static func == (lhs: ProductItemViewModel, rhs: ProductItemViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
