//
//  ProductDetailsView.swift
//  Harry Potter
//
//  Created by Fady Yecob on 14/11/2021.
//

import SwiftUI

struct ProductDetailsView: View {
    @ObservedObject var viewModel: ProductItemViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                imageView
                VStack {
                    titleView
                    subtitleView
                }
                .padding(4)
            }
        }
        .navigationBarItems(trailing: favoriteButton)
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder private var favoriteButton: some View {
        Button {
            viewModel.isFavorited.toggle()
        } label: {
            Image(systemName: viewModel.isFavorited ? "heart.fill" : "heart")
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
