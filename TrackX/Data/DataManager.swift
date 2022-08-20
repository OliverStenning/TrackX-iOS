//
//  DataManager.swift
//  TrackX
//
//  Created by Oliver Stenning on 20/08/2022.
//

import Foundation

class DataManager {
    
    //MARK: - Utility Properties
    private var networkManager: NetworkManager
    var error: String? = nil
    
    //MARK: - Data Properties
    // Dictionaries
    var fullLaunches: [String: FullLaunch] = [:]
    var capsules: [String: Capsule] = [:]
    var cores: [String: Core] = [:]
    var landpads: [String: Landpad] = [:]
    var launches: [String: Launch] = [:]
    var launchpads: [String: Launchpad] = [:]
    var payloads: [String: Payload] = [:]
    var rockets: [String: Rocket] = [:]
    
    // Arrays
    var fullLaunchesArray: [FullLaunch] = []
    var capsulesArray: [Capsule] = []
    var coresArray: [Core] = []
    var landpadsArray: [Landpad] = []
    var launchesArray: [Launch] = []
    var launchpadsArray: [Launchpad] = []
    var payloadsArray: [Payload] = []
    var rocketsArray: [Rocket] = []
    
    //MARK: - Initializers
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchData(completion: @escaping () -> Void) {
        let networkGroup = DispatchGroup()
    
        setLaunches(networkGroup: networkGroup)
        setRockets(networkGroup: networkGroup)
        setLaunchpads(networkGroup: networkGroup)
        setLandpads(networkGroup: networkGroup)
        setPayloads(networkGroup: networkGroup)
        setCores(networkGroup: networkGroup)
        
        networkGroup.notify(queue: .main) {
            self.createFullLaunches()
            completion()
        }
    }
    
    init(networkManager: NetworkManager, capsules: [String: Capsule], cores: [String: Core], landpads: [String: Landpad], launches: [String: Launch], launchpads: [String: Launchpad], payloads: [String: Payload], rockets: [String: Rocket]) {
        self.networkManager = networkManager
        self.capsules = capsules
        self.cores = cores
        self.landpads = landpads
        self.launches = launches
        self.launchpads = launchpads
        self.payloads = payloads
        self.rockets = rockets
    }
    
    func createFullLaunches() {
        guard error == nil else { return }
        var fullLaunchesArray: [FullLaunch] = []
        for launch in self.launchesArray {
            if let fullLaunch = self.createFullLaunch(from: launch.id) {
                fullLaunchesArray.append(fullLaunch)
                self.fullLaunches[launch.id] = fullLaunch
            }
        }
        self.fullLaunchesArray = fullLaunchesArray
    }
    
    func createFullLaunch(from launchId: String) -> FullLaunch? {
        guard let launch = launches[launchId] else { return nil }
        
        let rocket = rockets[launch.rocket ?? ""]
        let launchpad = launchpads[launch.launchpad ?? ""]
        
        var capsules: [Capsule] = []
        launch.capsules?.forEach({ capsuleId in
            if let capsule = self.capsules[capsuleId] {
                capsules.append(capsule)
            }
        })
        
        var payloads: [Payload] = []
        launch.payloads?.forEach({ payloadId in
            if let payload = self.payloads[payloadId] {
                payloads.append(payload)
            }
        })
        
        var cores: [Core] = []
        var coreLandpads: [Landpad] = []
        launch.cores?.forEach({ launchCore in
            if let coreId = launchCore.core {
                if let core = self.cores[coreId] {
                    cores.append(core)
                }
            }
            if let landpadId = launchCore.landpad {
                if let coreLandpad = self.landpads[landpadId] {
                    coreLandpads.append(coreLandpad)
                }
            }
        })
        
        let fullLaunch = FullLaunch(
            launch: launch,
            rocket: rocket,
            launchpad:  launchpad,
            capsules: capsules.isEmpty ? nil : capsules,
            payloads: payloads.isEmpty ? nil : payloads,
            cores: cores.isEmpty ? nil : cores,
            coreLandpads: coreLandpads.isEmpty ? nil : coreLandpads
        )
        return fullLaunch
    }
    
    //MARK: - Data Setters
    private func setLaunches(networkGroup: DispatchGroup) {
        networkGroup.enter()
        networkManager.getLaunches() { launchesArray, error in
            guard error == nil, let launchesArray = launchesArray else {
                self.error = error
                networkGroup.leave()
                return
            }
            
            self.launchesArray = launchesArray
            self.launches = Arrays.arrayToDictionary(launchesArray)
            networkGroup.leave()
        }
    }
    
    private func setRockets(networkGroup: DispatchGroup) {
        networkGroup.enter()
        networkManager.getRockets { rocketsArray, error in
            guard error == nil, let rocketsArray = rocketsArray else {
                self.error = error
                networkGroup.leave()
                return
            }
            
            self.rocketsArray = rocketsArray
            self.rockets = Arrays.arrayToDictionary(rocketsArray)
            networkGroup.leave()
        }
    }
    
    private func setLaunchpads(networkGroup: DispatchGroup) {
        networkGroup.enter()
        networkManager.getLaunchpads() { launchpadsArray, error in
            guard error == nil, let launchpadsArray = launchpadsArray else {
                self.error = error
                networkGroup.leave()
                return
            }
            
            self.launchpadsArray = launchpadsArray
            self.launchpads = Arrays.arrayToDictionary(launchpadsArray)
            networkGroup.leave()
        }
    }
    
    private func setLandpads(networkGroup: DispatchGroup) {
        networkGroup.enter()
        networkManager.getLandpads() { landpadsArray, error in
            guard error == nil, let landpadsArray = landpadsArray else {
                self.error = error
                networkGroup.leave()
                return
            }
            
            self.landpadsArray = landpadsArray
            self.landpads = Arrays.arrayToDictionary(landpadsArray)
            networkGroup.leave()
        }
    }
    
    private func setPayloads(networkGroup: DispatchGroup) {
        networkGroup.enter()
        networkManager.getPayloads() { payloadsArray, error in
            guard error == nil, let payloadsArray = payloadsArray else {
                self.error = error
                networkGroup.leave()
                return
            }
            
            self.payloadsArray = payloadsArray
            self.payloads = Arrays.arrayToDictionary(payloadsArray)
            networkGroup.leave()
        }
    }
    
    private func setCores(networkGroup: DispatchGroup) {
        networkGroup.enter()
        networkManager.getCores() { coresArray, error in
            guard error == nil, let coresArray = coresArray else {
                self.error = error
                networkGroup.leave()
                return
            }
            
            self.coresArray = coresArray
            self.cores = Arrays.arrayToDictionary(coresArray)
            networkGroup.leave()
        }
    }
    
}
