//
//  Landpad.swift
//  TrackX
//
//  Created by Oliver Stenning on 01/06/2022.
//

import Foundation

struct Landpad: Codable, Id {
    let id: String
    let name: String?
    let fullName: String?
    let status: String
    let type: String?
    let locality: String?
    let region: String?
    let latitude: Double?
    let longitude: Double?
    let landingAttempts: Int
    let landingSuccesses: Int
    let wikipedia: String?
    let details: String?
    let launches: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case status
        case type
        case locality
        case region
        case latitude
        case longitude
        case landingAttempts = "landing_attempts"
        case landingSuccesses = "landing_successes"
        case wikipedia
        case details
        case launches
    }
}
