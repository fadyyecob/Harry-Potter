//
//  SceneDelegate.swift
//  Harry Potter
//
//  Created by Fady Yecob on 13/11/2021.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        makeWindow(scene: scene)
    }
    
    private func makeWindow(scene: UIScene) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }
        
        let productsViewController = makeProductsViewController()
        
        let window = UIWindow(windowScene: windowScene)
        
        let navigationController = UINavigationController(rootViewController: productsViewController)
        navigationController.navigationBar.prefersLargeTitles = true
        
        window.rootViewController = navigationController
        
        self.window = window
        window.makeKeyAndVisible()
    }
    
    private func makeProductsViewController() -> UIViewController {
        let productsRepository = ProductsRepository()
        let productFavoritesRepository = ProductFavoritesRepository()
        
        let productsViewModel = ProductsViewModel(productsRepository: productsRepository, productFavoritesRepository: productFavoritesRepository)
        
        let hostingViewController = UIHostingController(rootView: ProductsView(viewModel: productsViewModel))
        
        return hostingViewController
    }
}

