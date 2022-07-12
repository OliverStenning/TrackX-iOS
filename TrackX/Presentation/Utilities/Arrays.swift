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

func moveToDictionary<T: Id>(_ array: [T]?) -> [String: T] {
    var dictionary: [String: T] = [:]
    array?.forEach() { item in
        dictionary[item.id] = item
    }
    return dictionary
}

func unixTimeSort(x: Launch, y: Launch) -> Bool {
    return x.dateUnix < y.dateUnix
}
