//
//  DataManager.swift
//  TrackX
//
//  Created by Oliver Stenning on 13/06/2022.
//

import Foundation

class DataManager {
    
    weak var delegate: LaunchDataManagerDelegate?
    
    private var launches: [String: Launch] = [:]
    private var rockets: [String: Rocket] = [:]
    private var launchpads: [String: Launchpad] = [:]
    private var landpads: [String: Landpad] = [:]
    private var cores: [String: Core] = [:]
    private var capsules: [String: Capsule] = [:]
    private var payloads: [String: Payload] = [:]
    
    func fetchData() {
        let networkManager = NetworkManager()
        let networkGroup = DispatchGroup()
    
        networkGroup.enter()
        networkManager.getLaunches() { launchArray, error in
            guard let launchArray = launchArray else {
                networkGroup.leave()
                return
            }

            let sortedLaunchArray = launchArray.sorted {
                $0.dateUnix > $1.dateUnix
            }
            sortedLaunchArray.forEach { launch in
                self.launches[launch.id] = launch
            }
            networkGroup.leave()
        }
        
        networkGroup.enter()
        networkManager.getRockets { rocketArray, error in
            rocketArray?.forEach() { rocket in
                self.rockets[rocket.id] = rocket
            }
            networkGroup.leave()
        }
        
        networkGroup.enter()
        networkManager.getLaunchpads() { launchpadArray, error in
            launchpadArray?.forEach() { launchpad in
                self.launchpads[launchpad.id] = launchpad
            }
            networkGroup.leave()
        }
        
        networkGroup.enter()
        networkManager.getLandpads() { landpadArray, error in
            landpadArray?.forEach() { landpad in
                self.landpads[landpad.id] = landpad
            }
            networkGroup.leave()
        }

        networkGroup.enter()
        networkManager.getPayloads() { payloadArray, error in
            payloadArray?.forEach() { payload in
                self.payloads[payload.id] = payload
            }
            networkGroup.leave()
        }
        
        networkGroup.enter()
        networkManager.getCores() { coreArray, error in
            coreArray?.forEach() { core in
                self.cores[core.id] = core
            }
            networkGroup.leave()
        }
        
        networkGroup.notify(queue: .main) {
            
            guard let delegate = self.delegate else { return }
            
            // Create dictionary of full launches
            var fullLaunches: [String: FullLaunch] = [:]
            for (key, launch) in self.launches {
                fullLaunches[key] = self.createFullLaunch(from: launch)
            }
            
            var previousLaunches: [Launch] = []
            var upcomingLaunches: [Launch] = []
            var allLaunches: [Launch]
            
            for (_, launch) in self.launches {
                if launch.upcoming {
                    upcomingLaunches.append(launch)
                } else {
                    previousLaunches.append(launch)
                }
            }
            allLaunches = previousLaunches + upcomingLaunches
            
            // Sort arrays chronologically
            previousLaunches.sort {
                $0.dateUnix > $1.dateUnix
            }
            upcomingLaunches.sort {
                $0.dateUnix < $1.dateUnix
            }
            allLaunches.sort {
                $0.dateUnix < $1.dateUnix
            }
            
            var previous = self.splitLaunchesIntoSections(launches: previousLaunches)
            previous.sectionNames[0] = "Latest"
            let previousLaunchTableData = LaunchTableData(sections: previous.sectionNames, launchIds: previous.sectionedIds, fullLaunches: fullLaunches)
            delegate.launchDataManager(self, previousLaunchesUpdate: previousLaunchTableData)
            
            var upcoming = self.splitLaunchesIntoSections(launches: upcomingLaunches)
            upcoming.sectionNames[0] = "Next"
            let upcomingLaunchTableData = LaunchTableData(sections: upcoming.sectionNames, launchIds: upcoming.sectionedIds, fullLaunches: fullLaunches)
            delegate.launchDataManager(self, upcomingLaunchesUpdate: upcomingLaunchTableData)
            
            var all = self.splitLaunchesIntoSections(launches: allLaunches)
            all.sectionNames[0] = "First"
            let allLaunchTableData = LaunchTableData(sections: all.sectionNames, launchIds: all.sectionedIds, fullLaunches: fullLaunches)
            delegate.launchDataManager(self, allLaunchesUpdate: allLaunchTableData)
            
            delegate.launchDataManager(self, dataWasUpdated: true)
            
        }
    }
    
    func splitLaunchesIntoSections(launches: [Launch]) -> (sectionNames: [String], sectionedIds: [[String]]) {
        var sectionNames: [String] = []
        var sectionIntervals: [DateInterval] = []
        var LaunchIds: [[String]] = []
        
        let yearInterval = DateInterval(start: Date().startOfYear(), end: Date().endOfYear())
        
        let shortFormatter = DateFormatter()
        shortFormatter.dateFormat = "MMMM"
        
        let longFormatter = DateFormatter()
        longFormatter.dateFormat = "MMMM yyyy"
        
        sectionNames.append("")
        LaunchIds.append([launches[0].id])
        
        for x in 1..<launches.count {
            let launchDate = Date(timeIntervalSince1970: TimeInterval(launches[x].dateUnix))
            var rangeExists: Bool = false
            for y in 0..<sectionIntervals.count {
                if sectionIntervals[y].contains(launchDate) {
                    LaunchIds[y+1].append(launches[x].id)
                    rangeExists = true
                }
            }
            
            if !rangeExists {
                let startDate = launchDate.startOfMonth()
                let endDate = launchDate.endOfMonth()
                var dateName: String
                
                if yearInterval.contains(launchDate) {
                    dateName = shortFormatter.string(from: startDate)
                } else {
                    dateName = longFormatter.string(from: startDate)
                }
                
                sectionNames.append(dateName)
                sectionIntervals.append(DateInterval(start: startDate, end: endDate))
                LaunchIds.append([launches[x].id])
            }
        }
        return (sectionNames, LaunchIds)
    }

    func createFullLaunch(from launch: Launch) -> FullLaunch {
        
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
            coreLandpads: coreLandpads
        )
        return fullLaunch
    }
    
}

struct LaunchTableData {
    let sections: [String]
    let launchIds: [[String]]
    let fullLaunches: [String: FullLaunch]
}

protocol LaunchDataManagerDelegate: AnyObject {
    func launchDataManager(_ manager: DataManager, previousLaunchesUpdate: LaunchTableData)
    func launchDataManager(_ manager: DataManager, upcomingLaunchesUpdate: LaunchTableData)
    func launchDataManager(_ manager: DataManager, allLaunchesUpdate: LaunchTableData)
    func launchDataManager(_ manager: DataManager, dataWasUpdated: Bool)
}
