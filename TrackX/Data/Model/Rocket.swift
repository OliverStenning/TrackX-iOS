//
//  Rocket.swift
//  TrackX
//
//  Created by Oliver Stenning on 31/05/2022.
//

import Foundation

struct Rocket: Codable, Id {
    let id: String
    let name: String?
    let type: String?
    let active: Bool?
    let stages: Int?
    let boosters: Int?
    let costPerLaunch: Int?
    let successRatePct: Int?
    let firstFlight: String?
    let country: String?
    let company: String?
    let height: Length?
    let diameter: Length?
    let mass: Mass?
    let payloadWeights: [PayloadMass]?
    let firstStage: FirstStage?
    let secondStage: SecondStage?
    let payloads: RocketPayload?
    let engines: Engine?
    let landingLegs: LandingLegs?
    let flickrImages: [String]?
    let wikipedia: String?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case active
        case stages
        case boosters
        case costPerLaunch = "cost_per_launch"
        case successRatePct = "success_rate_pct"
        case firstFlight = "first_flight"
        case country
        case company
        case height
        case diameter
        case mass
        case payloadWeights = "payload_weights"
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        case payloads
        case engines
        case landingLegs = "landing_legs"
        case flickrImages = "flickr_images"
        case wikipedia
        case description
    }
}

struct Length: Codable {
    let meters: Double?
    let feet: Double?
}

struct Mass: Codable {
    let kg: Int?
    let lb: Int?
}

struct PayloadMass: Codable {
    let id: String
    let name: String
    let kg: Int
    let lb: Int
}

struct FirstStage: Codable {
    let reusable: Bool?
    let engines: Int?
    let fuelAmountTons: Double?
    let burnTimeSec: Int?
    let thrustSeaLevel: Thrust?
    let thrustVacuum: Thrust?
    
    enum CodingKeys: String, CodingKey {
        case reusable
        case engines
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSec = "burn_time_sec"
        case thrustSeaLevel = "thrust_sea_level"
        case thrustVacuum = "thrust_vacuum"
    }
}

struct SecondStage: Codable {
    let reusable: Bool?
    let engines: Int?
    let fuelAmountTons: Double?
    let burnTimeSec: Int?
    let thrust: Thrust?
    
    enum CodingKeys: String, CodingKey {
        case reusable
        case engines
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSec = "burn_time_sec"
        case thrust
    }
}

struct Thrust: Codable {
    let kN: Int?
    let lbf: Int?
}

struct RocketPayload: Codable {
    let option1: String?
    let compositeFairing: Dimension?
    
    enum CodingKeys: String, CodingKey {
        case option1 = "option_1"
        case compositeFairing = "composite_fairing"
    }
}

struct Dimension: Codable {
    let height: Length?
    let diameter: Length?
}

struct Engine: Codable {
    let number: Int?
    let type: String?
    let version: String?
    let layout: String?
    let isp: Isp?
    let engineLossMax: Int?
    let propellant1: String?
    let propellant2: String?
    let thrustSeaLevel: Thrust?
    let thrustVacuum: Thrust?
    let thrustToWeight: Double?
    
    enum CodingKeys: String, CodingKey {
        case number
        case type
        case version
        case layout
        case isp
        case engineLossMax = "engine_loss_max"
        case propellant1 = "propellant_1"
        case propellant2 = "propellant_2"
        case thrustSeaLevel = "thrust_sea_level"
        case thrustVacuum = "thrust_vacuum"
        case thrustToWeight = "thrust_to_weight"
    }
}

struct Isp: Codable {
    let seaLevel: Int?
    let vacuum: Int?
    
    enum CodingKeys: String, CodingKey {
        case seaLevel = "sea_level"
        case vacuum
    }
}

struct LandingLegs: Codable {
    let number: Int?
    let material: String?
}
