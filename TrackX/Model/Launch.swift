//
//  Launch.swift
//  TrackX
//
//  Created by Oliver Stenning on 25/03/2022.
//

import Foundation

struct Launch {
    var name: String?
    var rocket: String?
    var launchpad: String?
    var details: String?
}

extension Launch: Decodable {
    
    enum LaunchCodingKeys: String, CodingKey {
        case name
        case rocket
        case launchpad
        case details
    }
    
    init(from decoder: Decoder) throws {
        let launchContainer = try decoder.container(keyedBy: LaunchCodingKeys.self)
        
        name = try launchContainer.decode(String?.self, forKey: .name)
        rocket = try launchContainer.decode(String?.self, forKey: .rocket)
        launchpad = try launchContainer.decode(String?.self, forKey: .launchpad)
        details = try launchContainer.decode(String?.self, forKey: .details)
    }
    
}

struct LaunchApiResponse {
    let launch: Launch
}

extension LaunchApiResponse: Decodable {
    
    private enum LaunchApiResponseCodingKeys: String, CodingKey {
        case launch
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LaunchApiResponseCodingKeys.self)
        
        launch = try container.decode(Launch.self, forKey: .launch)
    }
    
}

struct LaunchesApiResponse {
    let launches: [Launch]
}

extension LaunchesApiResponse: Decodable {
    
    private enum LaunchesApiResponseCodingKeys: String, CodingKey {
        case launches
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LaunchesApiResponseCodingKeys.self)
        
        launches = try container.decode([Launch].self, forKey: .launches)
    }
    
}
