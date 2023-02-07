//
//  LaunchProvider.swift
//  TrackX
//
//  Created by Oliver Stenning on 13/06/2022.
//

import Foundation

class LaunchProvider {
    
    //MARK: - Utility Properties
    let dataManager: DataManager
    
    weak var nextLaunchDelegate: NextLaunchDelegate?
    weak var scheduledLaunchesDelegate: ScheduledLaunchesDelegate?
    weak var recentLaunchesDelegate: RecentLaunchesDelegate?
    weak var launchTableDelegate: LaunchTableDelegate?
    
    //MARK: - Initializers
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    //MARK: - Data Functions
    func getNextLaunchData() {
        
    }
    
    func fetchNextLaunch() {
//        dataManager.fetchData(completion: fetchNextLaunchCompletion)
    }
    
    func fetchScheduledLaunches() {
//        dataManager.fetchData(completion: fetchScheduledLaunchesCompletion)
    }
    
    func fetchRecentLaunches() {
//        dataManager.fetchData(completion: fetchRecentLaunchesCompletion)
    }
    
    func fetchLaunchTableData() {
//        dataManager.fetchData(completion: fetchLaunchTableCompletionHandler)
    }
    
    //MARK: - Data Fetch Completion
    private func fetchNextLaunchCompletion() {
        print("Fetch next launch complete")
        guard let delegate = self.nextLaunchDelegate, dataManager.error == nil else { return }
        
        var scheduledFullLaunches: [FullLaunch] = []
        for fullLaunch in dataManager.fullLaunchesArray {
            if fullLaunch.launch.upcoming {
                scheduledFullLaunches.append(fullLaunch)
            }
        }
        scheduledFullLaunches.sort(by: Arrays.fullLaunchUnixTimeSort(x:y:))

        // Return first item with date in the future
        for fullLaunch in scheduledFullLaunches {
            if fullLaunch.launch.dateUnix > Int(Date().timeIntervalSince1970) {
                delegate.launchProvider(self, nextLaunchUpdate: fullLaunch)
                return
            }
        }
    }
    
    private func fetchScheduledLaunchesCompletion() {
        guard let delegate = self.scheduledLaunchesDelegate, dataManager.error == nil else { return }
        
        var scheduledFullLaunches: [FullLaunch] = []
        for fullLaunch in dataManager.fullLaunchesArray {
            if fullLaunch.launch.upcoming {
                scheduledFullLaunches.append(fullLaunch)
            }
        }
        scheduledFullLaunches.sort(by: Arrays.fullLaunchUnixTimeSort(x:y:))
        
        delegate.launchProvider(self, launchesUpdated: scheduledFullLaunches)
    }
    
    private func fetchRecentLaunchesCompletion() {
        guard let delegate = self.recentLaunchesDelegate, dataManager.error == nil else { return }
        
        var recentFullLaunches: [FullLaunch] = []
        for fullLaunch in dataManager.fullLaunchesArray {
            if !fullLaunch.launch.upcoming {
                recentFullLaunches.append(fullLaunch)
            }
        }
        recentFullLaunches.sort(by: Arrays.fullLaunchUnixTimeSort(x:y:))
        recentFullLaunches.reverse()
        
        delegate.launchProvider(self, launchesUpdated: recentFullLaunches)
    }
    
    private func fetchLaunchTableCompletionHandler() {
        guard let delegate = self.launchTableDelegate else { return }

        /*
         Only populate tableview with data if all network requests return successfully.
         This could be made less strict, but edge cases based on which combination of data is
         returned may cause UI issues. For now simpler to keep strict.
         */
        if let error = dataManager.error {
            delegate.launchProvider(self, dataFailedToUpDate: error)
            return
        }
        
        // Create dictionary of full launches
        var recentLaunches: [Launch] = []
        var scheduledLaunches: [Launch] = []
        var allLaunches: [Launch]
        
        for launch in dataManager.launchesArray {
            if launch.upcoming {
                scheduledLaunches.append(launch)
            } else {
                recentLaunches.append(launch)
            }
        }
        allLaunches = recentLaunches + scheduledLaunches
        
        // Sort arrays chronologically
        recentLaunches.sort(by: Arrays.launchUnixTimeSort(x:y:))
        scheduledLaunches.sort(by: Arrays.launchUnixTimeSort(x:y:))
        allLaunches.sort(by: Arrays.launchUnixTimeSort(x:y:))
        
        delegate.launchProvider(self, recentLaunchesUpdate: createTableData(launches: recentLaunches))
        delegate.launchProvider(self, scheduledLaunchesUpdate: createTableData(launches: scheduledLaunches))
        delegate.launchProvider(self, allLaunchesUpdate: createTableData(launches: allLaunches))
        delegate.launchProvider(self, dataWasUpdated: true)
    }
    
    //MARK: - Data Manipulation Functions
    private func createTableData(launches: [Launch]) -> LaunchTableData {
        let splitted = self.splitLaunchesIntoSections(launches: launches)
        return LaunchTableData(sections: splitted.sectionNames, launchIds: splitted.sectionedIds, fullLaunches: dataManager.fullLaunches)
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

protocol LaunchTableDelegate: AnyObject {
    func launchProvider(_ provider: LaunchProvider, scheduledLaunchesUpdate: LaunchTableData)
    func launchProvider(_ provider: LaunchProvider, recentLaunchesUpdate: LaunchTableData)
    func launchProvider(_ provider: LaunchProvider, allLaunchesUpdate: LaunchTableData)
    func launchProvider(_ provider: LaunchProvider, dataWasUpdated: Bool)
    func launchProvider(_ provider: LaunchProvider, dataFailedToUpDate: String)
}
