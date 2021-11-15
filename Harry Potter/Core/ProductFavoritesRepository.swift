//
//  ProductFavoritesRepository.swift
//  Harry Potter
//
//  Created by Fady Yecob on 14/11/2021.
//

import Foundation

class ProductFavoritesRepository {
    private let userDefaults = UserDefaults.standard
    private let favoritesKey = "productFavorites"
    
    private func getFavorites() -> [String] {
        let favoritesArray: [String]
        
        if let predefinedFavoritesArray = userDefaults.array(forKey: favoritesKey) as? [String] {
            favoritesArray = predefinedFavoritesArray
        } else {
            favoritesArray = [String]()
        }
        
        return favoritesArray
    }
    
    func addToFavorites(id: UUID) {
        var favorites = getFavorites()
        favorites.append(id.uuidString)
        
        userDefaults.setValue(favorites, forKey: favoritesKey)
    }
    
    func removeFromFavorites(id: UUID) {
        var favorites = getFavorites()
        
        guard let index = favorites.firstIndex(of: id.uuidString) else {
            return
        }
        favorites.remove(at: index)
        
        userDefaults.setValue(favorites, forKey: favoritesKey)
    }
    
    func isFavorited(id: UUID) -> Bool {
        getFavorites().contains(id.uuidString)
    }
    
}
