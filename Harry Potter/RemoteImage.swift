//
//  RemoteImage.swift
//  Harry Potter
//
//  Created by Fady Yecob on 14/11/2021.
//

import SwiftUI
import Combine
import Foundation

// Copied from https://www.vadimbulavin.com/asynchronous-swiftui-image-loading-from-url-with-combine-and-swift/
// Beacuase `AsyncImage` is only available since iOS 15
struct RemoteImage<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Placeholder

    init(url: URL, @ViewBuilder placeholder: () -> Placeholder) {
        self.placeholder = placeholder()
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }

    var body: some View {
        content
            .onAppear(perform: loader.load)
    }

    @ViewBuilder private var content: some View {
        if let image = loader.image {
            Image(uiImage: image)
                .resizable()
        } else {
            placeholder
        }
    }
}

fileprivate class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: URL
    private var cancellables = Set<AnyCancellable>()
    private let urlSession = URLSession.shared
    private let cache = NSCache<NSURL, UIImage>()

    init(url: URL) {
        self.url = url
    }
    
    func load() {
        if let image = cache.object(forKey: url as NSURL) {
             self.image = image
             return
         }
        
        urlSession.dataTaskPublisher(for: url)
            .map {
                UIImage(data: $0.data)
            }
            .replaceError(with: nil)
            .handleEvents(receiveOutput: { [weak self] in
                self?.cache($0)
            })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.image = $0
            }
            .store(in: &cancellables)
        
    }
    
    func cancel() {
        cancellables.forEach {
            $0.cancel()
        }
    }
    
    private func cache(_ image: UIImage?) {
        guard let image = image else {
            cache.removeObject(forKey: url as NSURL)
            return
        }

        cache.setObject(image, forKey: url as NSURL)
    }
    
    deinit {
        cancel()
    }
}
