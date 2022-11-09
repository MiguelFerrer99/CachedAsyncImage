//
//  CachedAsyncImage.swift
//  CachedAsyncImage
//
//  Created by Miguel Ferrer Fornali on 9/11/22.
//

import SwiftUI

// MARK: - Public Representable
public struct CachedAsyncImageRepresentable {
    let imageIdForCache: String
    let fullname: String
    let urlString: String
    
    public init(imageIdForCache: String, fullname: String, urlString: String) {
        self.imageIdForCache = imageIdForCache
        self.fullname = fullname
        self.urlString = urlString
    }
}

// MARK: - Public CachedAsyncImage View
public struct CachedAsyncImage<Placeholder: View, ImageLoaded: View>: View {
    // MARK: - Parameters
    @StateObject private var imageLoader: CachedAsyncImageLoader
    private let representable: CachedAsyncImageRepresentable
    private let placeholder: Placeholder
    private let imageLoaded: (UIImage) -> ImageLoaded
    
    // MARK: - Init
    public init(representable: CachedAsyncImageRepresentable, @ViewBuilder placeholder: () -> Placeholder, @ViewBuilder imageLoaded: @escaping (UIImage) -> ImageLoaded) {
        self.representable = representable
        self.placeholder = placeholder()
        self.imageLoaded = imageLoaded
        self._imageLoader = StateObject(wrappedValue: CachedAsyncImageLoader(
            imageIdForCache: representable.imageIdForCache,
            fullname: representable.fullname,
            urlString: representable.urlString))
    }
    
    // MARK: - Main view
    public var body: some View {
        content
            .onLoad { imageLoader.load() }
    }
    
    private var content: some View {
        Group {
            if imageLoader.isLoading {
                placeholder
            } else {
                imageLoaded(imageLoader.getImage())
            }
        }
    }
}
