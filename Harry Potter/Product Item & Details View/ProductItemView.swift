//
//  ProductItemView.swift
//  Harry Potter
//
//  Created by Fady Yecob on 14/11/2021.
//

import SwiftUI

struct ProductItemView: View {
    @ObservedObject var viewModel: ProductItemViewModel
    
    var body: some View {
        VStack {
            imageView
            VStack {
                titleView
                subtitleView
            }
            .padding(4)
        }
        .frame(height: 300)
        .cornerRadius(5)
        .overlay(favoriteImage, alignment: .topTrailing)
    }
    
    @ViewBuilder private var favoriteImage: some View {
        if viewModel.isFavorited {
            Image(systemName: "heart.fill")
                .foregroundColor(.init(UIColor.systemRed))
                .frame(width: 44, height: 44)
        }
    }
    
    @ViewBuilder private var imageView: some View {
        if let imageURL = viewModel.imageURL {
            RemoteImage(url: imageURL) {
                ProgressView()
            }
            .aspectRatio(contentMode: .fit)
        }
    }
    
    private var titleView: some View {
        Text(viewModel.title)
            .font(.custom("AvenirNext-DemiBold", size: 12))
            .foregroundColor(Color.productTextColor)
    }
    
    @ViewBuilder private var subtitleView: some View {
        if let subtitle = viewModel.subtitle {
            Text(subtitle)
                .font(.custom("AvenirNext-Regular", size: 11))
                .foregroundColor(Color.productTextColor)
        }
    }
}
