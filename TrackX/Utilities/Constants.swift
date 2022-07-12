//
//  Constants.swift
//  TrackX
//
//  Created by Oliver Stenning on 12/07/2022.
//

import Foundation

enum ImageCacheConstants {
    static let countLimit = 100
    static let memoryLimit = 1024 * 1024 * 100 // 100MB
    static let maxConcurrentImageLoading = 5
}

enum LaunchConstants {
    // Images before this date use placeholder images due to older image quality
    static let networkImageStartTimeUnix = 1420070400 // Unix time of Jan 1st 2016
}
