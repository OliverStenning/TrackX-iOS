//
//  FullLaunch.swift
//  TrackX
//
//  Created by Oliver Stenning on 14/06/2022.
//

import Foundation

class FullLaunch {

    let launch: Launch
    let rocket: Rocket?
    let launchpad: Launchpad?
    let capsules: [Capsule]?
    let payloads: [Payload]?
    let cores: [Core]?
    let coreLandpads: [Landpad]?

    init(launch: Launch, rocket: Rocket?, launchpad: Launchpad?, capsules: [Capsule]?, payloads: [Payload]?, cores: [Core]?, coreLandpads: [Landpad]?) {
        self.launch = launch
        self.rocket = rocket
        self.launchpad = launchpad
        self.capsules = capsules
        self.payloads = payloads
        self.cores = cores
        self.coreLandpads = coreLandpads
    }
    
    
    
}
