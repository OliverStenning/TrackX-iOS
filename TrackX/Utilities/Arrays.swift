//
//  Arrays.swift
//  TrackX
//
//  Created by Oliver Stenning on 12/07/2022.
//

import Foundation

protocol Id {
    var id: String { get }
}

struct Arrays {
    
    static func arrayToDictionary<T: Id>(_ array: [T]) -> [String: T] {
        var dictionary: [String: T] = [:]
        array.forEach() { item in
            dictionary[item.id] = item
        }
        return dictionary
    }
    
    static func launchUnixTimeSort(x: Launch, y: Launch) -> Bool {
        return x.dateUnix < y.dateUnix
    }
    
    static func fullLaunchUnixTimeSort(x: FullLaunch, y: FullLaunch) -> Bool {
        return x.launch.dateUnix < y.launch.dateUnix
    }
    
}
