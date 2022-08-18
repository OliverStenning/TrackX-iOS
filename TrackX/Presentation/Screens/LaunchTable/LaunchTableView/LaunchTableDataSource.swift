//
//  LaunchTableDataSource.swift
//  TrackX
//
//  Created by Oliver Stenning on 14/06/2022.
//

import UIKit

struct LaunchCells {
    static let recent = "LaunchCellPrimary"
    static let scheduled = "LaunchCellSecondary"
}

struct LaunchTableData {
    let sections: [String]
    let launchIds: [[String]]
    let fullLaunches: [String: FullLaunch]
}

enum LaunchType {
    case scheduled
    case recent
    case all
}

class LaunchTableDataSource: NSObject, UITableViewDataSource {
    
    var ascendingSections: [String]
    var ascendingLaunchIds: [[String]]
    
    var descendingSections: [String]
    var descendingLaunchIds: [[String]]
    
    var launches: [String: FullLaunch]
    var launchType: LaunchType
    var ascending: Bool
    
    init(launchType: LaunchType, launchTableData: LaunchTableData, ascending: Bool) {
        self.launchType = launchType
        self.launches = launchTableData.fullLaunches
        
        self.ascendingSections = launchTableData.sections
        self.descendingSections = launchTableData.sections.reversed()
        
        self.ascendingLaunchIds = launchTableData.launchIds
        self.descendingLaunchIds = launchTableData.launchIds.reversed()
        for x in 0 ..< descendingLaunchIds.count {
            descendingLaunchIds[x].reverse()
        }
        
        self.ascending = ascending
        super.init()
        self.updateFirstSectionNames()
    }
    
    private func updateFirstSectionNames() {
        updateAscendingFirstSectionName()
        updateDescendingFirstSectionName()
    }
    
    private func updateAscendingFirstSectionName() {
        let newAscendingSectionName: String = getFirstSectionName(sectionAscending: true)
        if !ascendingLaunchIds.isEmpty {
            if ascendingLaunchIds[0].count == 1 {
                ascendingSections[0] = newAscendingSectionName
            } else {
                let newFirstLaunchId = ascendingLaunchIds[0][0]
                ascendingLaunchIds[0].removeFirst()
                ascendingLaunchIds.insert([newFirstLaunchId], at: 0)
                ascendingSections.insert(newAscendingSectionName, at: 0)
            }
        }
    }
    
    private func updateDescendingFirstSectionName() {
        let newDescendingSectionName: String = getFirstSectionName(sectionAscending: false)
        if !descendingLaunchIds.isEmpty {
            if descendingLaunchIds[0].count == 1 {
                descendingSections[0] = newDescendingSectionName
            } else {
                let newFirstLaunchId = descendingLaunchIds[0][0]
                descendingLaunchIds[0].removeFirst()
                descendingLaunchIds.insert([newFirstLaunchId], at: 0)
                descendingSections.insert(newDescendingSectionName, at: 0)
            }
        }
    }
    
    private func getFirstSectionName(sectionAscending: Bool) -> String {
        switch launchType {
            case .recent:
                return sectionAscending ? "First" : "Latest"
            case .scheduled:
                return sectionAscending ? "Next" : "Last Scheduled"
            case .all:
                return sectionAscending ? "First" : "Last Scheduled"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ascending ? ascendingSections.count : descendingSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ascending ? ascendingLaunchIds[section].count : descendingLaunchIds[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if launchType == .recent || launchType == .all {
            let cell = tableView.dequeueReusableCell(withIdentifier: LaunchCells.recent, for: indexPath) as! RecentLaunchTableCell
            cell.configure(with: launches[ascending ? ascendingLaunchIds[indexPath.section][indexPath.row] : descendingLaunchIds[indexPath.section][indexPath.row]])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: LaunchCells.scheduled, for: indexPath) as! ScheduledLaunchTableCell
            cell.configure(with: launches[ascending ? ascendingLaunchIds[indexPath.section][indexPath.row] : descendingLaunchIds[indexPath.section][indexPath.row]])
            return cell
        }
    }
    
    func section(at index: Int) -> String {
        return ascending ? ascendingSections[index] : descendingSections[index]
    }
    
    func launchId(section: Int, row: Int) -> String {
        return ascending ? ascendingLaunchIds[section][row] : descendingLaunchIds[section][row]
    }
    
    func launch(section: Int, row: Int) -> FullLaunch? {
        return ascending ? launches[launchId(section: section, row: row)] : launches[launchId(section: section, row: row)]
    }
}
