//
//  LaunchProvider.swift
//  TrackX
//
//  Created by Oliver Stenning on 13/06/2022.
//

import Foundation

class LaunchProvider {
    
    //MARK: - Utility Properties
    weak var launchProviderDelegate: LaunchProviderDelegate?
    
    private var networkManager: NetworkManager
    private var error: String? = nil
    
    weak var nextLaunchDelegate: NextLaunchDelegate?
    weak var scheduledLaunchesDelegate: ScheduledLaunchesDelegate?
    weak var recentLaunchesDelegate: RecentLaunchesDelegate?
    
    //MARK: - Data Properties
    private var capsules: [String: Capsule] = [:]
    private var cores: [String: Core] = [:]
    private var landpads: [String: Landpad] = [:]
    private var launches: [String: Launch] = [:]
    private var launchpads: [String: Launchpad] = [:]
    private var payloads: [String: Payload] = [:]
    private var rockets: [String: Rocket] = [:]
    
    //MARK: - Initializers
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
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
    
    //MARK: - Data Functions
    func fetchNextLaunch() {
        fetchData(completion: fetchNextLaunchCompletion)
    }
    
    func fetchScheduledLaunches() {
        fetchData(completion: fetchScheduledLaunchesCompletion)
    }
    
    func fetchRecentLaunches() {
        fetchData(completion: fetchRecentLaunchesCompletion)
    }
    
    func fetchLaunchListData() {
        fetchData(completion: fetchLaunchListCompletionHandler)
    }
    
    private func fetchData(completion: @escaping () -> Void) {
        let networkGroup = DispatchGroup()
    
        setLaunches(networkGroup: networkGroup)
        setRockets(networkGroup: networkGroup)
        setLaunchpads(networkGroup: networkGroup)
        setLandpads(networkGroup: networkGroup)
        setPayloads(networkGroup: networkGroup)
        setCores(networkGroup: networkGroup)
        
        networkGroup.notify(queue: .main, execute: completion)
    }
    
    //MARK: - Data Setters
    private func setLaunches(networkGroup: DispatchGroup) {
        networkGroup.enter()
        networkManager.getLaunches() { launchArray, error in
            guard error == nil, let launchArray = launchArray else {
                self.error = error
                networkGroup.leave()
                return
            }
            self.launches = Arrays.arrayToDictionary(launchArray)
            networkGroup.leave()
        }
    }
    
    private func setRockets(networkGroup: DispatchGroup) {
        networkGroup.enter()
        networkManager.getRockets { rocketArray, error in
            guard error == nil, let rocketArray = rocketArray else {
                self.error = error
                networkGroup.leave()
                return
            }
            self.rockets = Arrays.arrayToDictionary(rocketArray)
            networkGroup.leave()
        }
    }
    
    private func setLaunchpads(networkGroup: DispatchGroup) {
        networkGroup.enter()
        networkManager.getLaunchpads() { launchpadArray, error in
            guard error == nil, let launchpadArray = launchpadArray else {
                self.error = error
                networkGroup.leave()
                return
            }
            self.launchpads = Arrays.arrayToDictionary(launchpadArray)
            networkGroup.leave()
        }
    }
    
    private func setLandpads(networkGroup: DispatchGroup) {
        networkGroup.enter()
        networkManager.getLandpads() { landpadArray, error in
            guard error == nil, let landpadArray = landpadArray else {
                self.error = error
                networkGroup.leave()
                return
            }
            self.landpads = Arrays.arrayToDictionary(landpadArray)
            networkGroup.leave()
        }
    }
    
    private func setPayloads(networkGroup: DispatchGroup) {
        networkGroup.enter()
        networkManager.getPayloads() { payloadArray, error in
            guard error == nil, let payloadArray = payloadArray else {
                self.error = error
                networkGroup.leave()
                return
            }
            self.payloads = Arrays.arrayToDictionary(payloadArray)
            networkGroup.leave()
        }
    }
    
    private func setCores(networkGroup: DispatchGroup) {
        networkGroup.enter()
        networkManager.getCores() { coreArray, error in
            guard error == nil, let coreArray = coreArray else {
                self.error = error
                networkGroup.leave()
                return
            }
            self.cores = Arrays.arrayToDictionary(coreArray)
            networkGroup.leave()
        }
    }
    
    //MARK: - Data Fetch Completion
    private func fetchNextLaunchCompletion() {
        guard let delegate = self.nextLaunchDelegate else { return }
        if let _ = self.error {
            return
        }
        
        var upcomingLaunches: [Launch] = []
        
        for (_, launch) in self.launches {
            if launch.upcoming {
                upcomingLaunches.append(launch)
            }
        }
        
        // Sort arrays chronologically
        upcomingLaunches.sort(by: Arrays.unixTimeSort(x:y:))
        
        if !upcomingLaunches.isEmpty {
            delegate.launchProvider(self, nextLaunchUpdate: self.createFullLaunch(from: upcomingLaunches[2]))
        }
    }
    
    private func fetchScheduledLaunchesCompletion() {
        guard let delegate = self.scheduledLaunchesDelegate else { return }
        if let _ = error {
            return
        }
        
        var scheduledLaunches: [Launch] = []

        for (_, launch) in self.launches {
            if launch.upcoming {
                scheduledLaunches.append(launch)
            }
        }
        
        // Sort arrays chronologically
        scheduledLaunches.sort(by: Arrays.unixTimeSort(x:y:))
        
        var scheduledFullLaunches: [FullLaunch] = []
        for launch in scheduledLaunches {
            scheduledFullLaunches.append(self.createFullLaunch(from: launch))
        }
        
        delegate.launchProvider(self, launchesUpdated: scheduledFullLaunches)
    }
    
    private func fetchRecentLaunchesCompletion() {
        guard let delegate = self.recentLaunchesDelegate else { return }
        if let _ = error {
            return
        }
        
        var recentLaunches: [Launch] = []
        
        for (_, launch) in self.launches {
            if !launch.upcoming {
                recentLaunches.append(launch)
            }
        }
        
        recentLaunches.sort(by: Arrays.unixTimeSort(x:y:))
        recentLaunches.reverse()
        
        var recentFullLaunches: [FullLaunch] = []
        for launch in recentLaunches {
            recentFullLaunches.append(self.createFullLaunch(from: launch))
        }
        
        delegate.launchProvider(self, launchesUpdated: recentFullLaunches)
    }
    
    private func fetchLaunchListCompletionHandler() {
        guard let delegate = self.launchProviderDelegate else { return }

        /*
         Only populate tableview with data if all network requests return successfully.
         This could be made less strict, but edge cases based on which combination of data is
         returned may cause UI issues. For now simpler to keep strict.
         */
        if let error = self.error {
            delegate.launchProvider(self, dataFailedToUpDate: error)
            return
        }
        
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
        previousLaunches.sort(by: Arrays.unixTimeSort(x:y:))
        upcomingLaunches.sort(by: Arrays.unixTimeSort(x:y:))
        allLaunches.sort(by: Arrays.unixTimeSort(x:y:))
        
        delegate.launchProvider(self, previousLaunchesUpdate: createTableData(launches: previousLaunches, fullLaunches: fullLaunches))
        delegate.launchProvider(self, upcomingLaunchesUpdate: createTableData(launches: upcomingLaunches, fullLaunches: fullLaunches))
        delegate.launchProvider(self, allLaunchesUpdate: createTableData(launches: allLaunches, fullLaunches: fullLaunches))
        delegate.launchProvider(self, dataWasUpdated: true)
    }
    
    //MARK: - Data Manipulation Functions
    private func createTableData(launches: [Launch], fullLaunches: [String: FullLaunch]) -> LaunchTableData {
        let splitted = self.splitLaunchesIntoSections(launches: launches)
        return LaunchTableData(sections: splitted.sectionNames, launchIds: splitted.sectionedIds, fullLaunches: fullLaunches)
    }
    
    private func splitLaunchesIntoSections(launches: [Launch]) -> (sectionNames: [String], sectionedIds: [[String]]) {
        var sectionNames: [String] = []
        var sectionIntervals: [DateInterval] = []
        var LaunchIds: [[String]] = []
        
        let yearInterval = DateInterval(start: Date().startOfYear(), end: Date().endOfYear())
        
        let shortFormatter = DateFormatter()
        shortFormatter.dateFormat = "MMMM"
        
        let longFormatter = DateFormatter()
        longFormatter.dateFormat = "MMMM yyyy"
        
        for x in 0..<launches.count {
            let launchDate = Date(timeIntervalSince1970: TimeInterval(launches[x].dateUnix))
            var rangeExists: Bool = false
            for y in 0..<sectionIntervals.count {
                if sectionIntervals[y].contains(launchDate) {
                    LaunchIds[y].append(launches[x].id)
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

    private func createFullLaunch(from launch: Launch) -> FullLaunch {
        
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
    
}

protocol NextLaunchDelegate: AnyObject {
    func launchProvider(_ provider: LaunchProvider, nextLaunchUpdate: FullLaunch)
}

protocol ScheduledLaunchesDelegate: AnyObject {
    func launchProvider(_ provider: LaunchProvider, launchesUpdated: [FullLaunch])
}

protocol RecentLaunchesDelegate: AnyObject {
    func launchProvider(_ provider: LaunchProvider, launchesUpdated: [FullLaunch])
}

protocol LaunchProviderDelegate: AnyObject {
    func launchProvider(_ provider: LaunchProvider, previousLaunchesUpdate: LaunchTableData)
    func launchProvider(_ provider: LaunchProvider, upcomingLaunchesUpdate: LaunchTableData)
    func launchProvider(_ provider: LaunchProvider, allLaunchesUpdate: LaunchTableData)
    func launchProvider(_ provider: LaunchProvider, dataWasUpdated: Bool)
    func launchProvider(_ provider: LaunchProvider, dataFailedToUpDate: String)
}
