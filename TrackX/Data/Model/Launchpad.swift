//
//  Launchpad.swift
//  TrackX
//
//  Created by Oliver Stenning on 01/06/2022.
//

import Foundation

struct Launchpad: Codable {
    let id: String
    let name: String?
    let fullName: String?
    let status: String
    let locality: String?
    let region: String?
    let timezone: String?
    let latitude: Double?
    let longitude: Double?
    let launchAttempts: Int
    let launchSuccesses: Int
    let rockets: [String]?
    let launches: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case status
        case locality
        case region
        case timezone
        case latitude
        case longitude
        case launchAttempts = "launch_attempts"
        case launchSuccesses = "launch_successes"
        case rockets
        case launches
    }
    
}
