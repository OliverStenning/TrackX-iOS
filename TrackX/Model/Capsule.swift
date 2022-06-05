//
//  Capsule.swift
//  TrackX
//
//  Created by Oliver Stenning on 01/06/2022.
//

import Foundation

struct Capsule: Codable {
    let id: String
    let serial: String
    let status: String
    let type: String
    let dragon: String?
    let reuseCount: Int
    let waterLandings: Int
    let landLandings: Int
    let lastUpdate: String?
    let launches: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case serial
        case status
        case type
        case dragon
        case reuseCount = "reuse_count"
        case waterLandings = "water_landings"
        case landLandings = "land_landings"
        case lastUpdate = "last_update"
        case launches
    }
}
