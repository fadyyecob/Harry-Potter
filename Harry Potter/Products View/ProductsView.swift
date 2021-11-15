//
//  ProductsView.swift
//  Harry Potter
//
//  Created by Fady Yecob on 13/11/2021.
//

import SwiftUI

struct ProductsView: View {
    let viewModel: ProductsViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVGrid(columns: makeGridItems(viewWidth: geometry.size.width)) {
                    productGridItems
                }
            }
        }
        .navigationTitle("Products")
        .navigationBarTitleDisplayMode(.large)
    }
    
    private var productGridItems: some View {
        ForEach((viewModel.products), id: \.self) { product in
            NavigationLink(destination: ProductDetailsView(viewModel: product)) {
                ProductItemView(viewModel: product)
                    .background(itemBackground)
              }
        }
    }
    
    private var itemBackground: some View {
        RoundedRectangle(cornerRadius: 5)
            .foregroundColor(.init(UIColor.systemBackground))
            .shadow(radius: 5)
    }
    
    private func makeGridItems(viewWidth: CGFloat) -> [GridItem] {
        let halfScreenGridItem = GridItem(.fixed(viewWidth * 0.45))
        
        return [halfScreenGridItem, halfScreenGridItem]
    }
}
