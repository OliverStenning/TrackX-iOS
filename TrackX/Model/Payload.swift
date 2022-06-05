//
//  Payload.swift
//  TrackX
//
//  Created by Oliver Stenning on 01/06/2022.
//

import Foundation

struct Payload: Codable {
    let id: String
    let name: String?
    let type: String?
    let reused: Bool
    let launch: String?
    let customers: [String]?
    let noradIds: [Int]?
    let nationalities: [String]?
    let manufacturers: [String]?
    let massKg: Double?
    let massLbs: Double?
    let orbit: String?
    let referenceSystem: String?
    let regime: String?
    let longitude: Double?
    let semiMajorAxisKm: Double?
    let eccentricity: Double?
    let periapsisKm: Double?
    let apoapsisKm: Double?
    let inclinationDeg: Double?
    let periodMin: Double?
    let lifespanYears: Double?
    let epoch: String?
    let meanMotion: Double?
    let raan: Double?
    let argOfPericenter: Double?
    let meanAnomaly: Double?
    let dragon: Dragon?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case reused
        case launch
        case customers
        case noradIds = "norad_ids"
        case nationalities
        case manufacturers
        case massKg = "mass_kg"
        case massLbs = "mass_lbs"
        case orbit
        case referenceSystem = "reference_system"
        case regime
        case longitude
        case semiMajorAxisKm = "semi_major_axis_km"
        case eccentricity
        case periapsisKm = "periapsis_km"
        case apoapsisKm = "apoapsis_km"
        case inclinationDeg = "inclination_deg"
        case periodMin = "period_min"
        case lifespanYears = "lifespan_years"
        case epoch
        case meanMotion = "mean_motion"
        case raan
        case argOfPericenter = "arg_of_pericenter"
        case meanAnomaly = "mean_anomaly"
        case dragon
    }
}

struct Dragon: Codable {
    let capsule: String?
    let massReturnedKg: Double?
    let massReturnedLbs: Double?
    let flightTimeSec: Double?
    let manifest: String?
    let waterLanding: Bool?
    let landLanding: Bool?
    
    enum CodingKeys: String, CodingKey {
        case capsule
        case massReturnedKg = "mass_returned_kg"
        case massReturnedLbs = "mass_returned_lbs"
        case flightTimeSec = "flight_time_sec"
        case manifest
        case waterLanding = "water_landing"
        case landLanding = "land_landing"
    }
}
