//
//  ImageCacheManager.swift
//  CachedAsyncImage
//
//  Created by Miguel Ferrer Fornali on 9/11/22.
//

import UIKit

final class ImageCacheManager: NSObject {
    // MARK: - Parameters
    static let shared = ImageCacheManager()
    private var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()
    
    // MARK: - Init
    private override init() {}
    
    // MARK: - Functions
    func add(image: UIImage, name: String) {
        imageCache.setObject(image, forKey: name as NSString)
    }
    
    func remove(name: String) {
        imageCache.removeObject(forKey: name as NSString)
    }
    
    func get(name: String) -> UIImage? {
        imageCache.object(forKey: name as NSString)
    }
}
