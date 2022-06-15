//
//  Core.swift
//  TrackX
//
//  Created by Oliver Stenning on 01/06/2022.
//

import Foundation

struct Core: Codable {
    let id: String
    let serial: String
    let block: Int?
    let status: String
    let reuseCount: Int
    let rtlsAttempts: Int
    let rtlsLandings: Int
    let asdsAttempts: Int
    let asdsLandings: Int
    let lastUpdate: String?
    let launches: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case serial
        case block
        case status
        case reuseCount = "reuse_count"
        case rtlsAttempts = "rtls_attempts"
        case rtlsLandings = "rtls_landings"
        case asdsAttempts = "asds_attempts"
        case asdsLandings = "asds_landings"
        case lastUpdate = "last_update"
        case launches
    }
}
