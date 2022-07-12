//
//  ImageLoader.swift
//  TrackX
//
//  Created by Oliver Stenning on 22/06/2022.
//

import Foundation
import Combine
import UIKit

final class ImageLoader {
    
    public static let shared = ImageLoader()
    
    private let cache: ImageCacheType
    private lazy var backgroundQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = ImageCacheConstants.maxConcurrentImageLoading
        return queue
    }()
    
    public init(cache: ImageCacheType = ImageCache()) {
        self.cache = cache
    }
    
    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        if let image = cache[url] {
            return Just(image).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, _) -> UIImage? in return UIImage(data: data) }
            .catch { error in return Just(nil) }
            .handleEvents(receiveOutput: {[unowned self] image in
                guard let image = image else { return }
                self.cache[url] = image
            })
            .subscribe(on: backgroundQueue)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}
