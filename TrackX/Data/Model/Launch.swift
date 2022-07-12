//
//  Launch.swift
//  TrackX
//
//  Created by Oliver Stenning on 25/03/2022.
//

import Foundation

struct Launch: Codable, Id {
    let id: String
    let flightNumber: Int
    let name: String
    let dateUtc: String
    let dateUnix: Int
    let dateLocal: String
    let datePrecision: String
    let staticFireDateUtc: String?
    let staticFireDateUnix: Int?
    let tbd: Bool
    let net: Bool
    let window: Int?
    let rocket: String?
    let success: Bool?
    let failures: [Failure]?
    let upcoming: Bool
    let details: String?
    let fairings: Fairing?
    let crew: [Crew]?
    let ships: [String]?
    let capsules: [String]?
    let payloads: [String]?
    let launchpad: String?
    let cores: [LaunchCore]?
    let links: Links?
    let autoUpdate: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case flightNumber = "flight_number"
        case name
        case dateUtc = "date_utc"
        case dateUnix = "date_unix"
        case dateLocal = "date_local"
        case datePrecision = "date_precision"
        case staticFireDateUtc = "static_fire_date_utc"
        case staticFireDateUnix = "static_fire_date_unix"
        case tbd
        case net
        case window
        case rocket
        case success
        case failures
        case upcoming
        case details
        case fairings
        case crew
        case ships
        case capsules
        case payloads
        case launchpad
        case cores
        case links
        case autoUpdate = "auto_update"
    }
}

struct Failure: Codable {
    var time: Int?
    var altitude: Int?
    var reason: String?
}

struct Fairing: Codable {
    var reused: Bool?
    var recoveryAttempt: Bool?
    var recovered: Bool?
    var ships: [String]?
    
    enum CodingKeys: String, CodingKey {
        case reused
        case recoveryAttempt = "recovery_attempt"
        case recovered
        case ships
    }
}

struct Crew: Codable {
    var crew: String?
    var role: String?
}

struct LaunchCore: Codable {
    var core: String?
    var flight: Int?
    var gridfins: Bool?
    var legs: Bool?
    var reused: Bool?
    var landingAttempt: Bool?
    var landingSuccess: Bool?
    var landingType: String?
    var landpad: String?
    
    enum CodingKeys: String, CodingKey {
        case core
        case flight
        case gridfins
        case legs
        case reused
        case landingAttempt = "landing_attempt"
        case landingSuccess = "landing_success"
        case landingType = "landing_type"
        case landpad
    }
}

struct Links: Codable {
    var patch: Patch?
    var reddit: Reddit?
    var flickr: Flickr?
    var presskit: String?
    var webcast: String?
    var youtubeId: String?
    var article: String?
    var wikipedia: String?
    
    enum CodingKeys: String, CodingKey {
        case patch
        case reddit
        case flickr
        case presskit
        case webcast
        case youtubeId = "youtube_id"
        case article
        case wikipedia
    }
}

struct Patch: Codable {
    var small: String?
    var large: String?
}

struct Reddit: Codable {
    var campaign: String?
    var launch: String?
    var media: String?
    var recovery: String?
}

struct Flickr: Codable {
    var small: [String]?
    var original: [String]?
}
