//
//  LaunchTableDataSource.swift
//  TrackX
//
//  Created by Oliver Stenning on 14/06/2022.
//

import UIKit

struct LaunchCells {
    static let launchCellPrimary = "LaunchCellPrimary"
    static let launchCellSecondary = "LaunchCellSecondary"
}

struct LaunchTableData {
    let sections: [String]
    let launchIds: [[String]]
    let fullLaunches: [String: FullLaunch]
}

enum LaunchType {
    case previous
    case upcoming
    case all
}

class LaunchTableDataSource: NSObject, UITableViewDataSource {
    
    var sections: [String]
    var launchIds: [[String]]
    var launches: [String: FullLaunch]
    var launchType: LaunchType
    
    init(launchType: LaunchType, launchTableData: LaunchTableData) {
        self.launchType = launchType
        self.sections = launchTableData.sections
        self.launchIds = launchTableData.launchIds
        self.launches = launchTableData.fullLaunches
        super.init()
        //self.updateFirstSectionName()
    }
    
    func toggleOrder() {
        sections.reverse()
        launchIds.reverse()
        for x in 0..<launchIds.count {
            launchIds[x].reverse()
        }
    }
    
    private func updateFirstSectionName() {
        if !sections.isEmpty {
            switch launchType {
                case .previous:
                    sections[0] = "Latest"
                case .upcoming:
                    sections[0] = "Next"
                case .all:
                    sections[0] = "First"
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launchIds[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: LaunchCells.launchCellPrimary, for: indexPath) as! LaunchTablePrimaryCell
            cell.configure(with: launches[launchIds[indexPath.section][indexPath.row]])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: LaunchCells.launchCellSecondary, for: indexPath) as! LaunchTableSecondaryCell
            cell.configure(with: launches[launchIds[indexPath.section][indexPath.row]])
            return cell
        }
    }
    
    func section(at index: Int) -> String {
        return sections[index]
    }
    
    func launchId(section: Int, row: Int) -> String {
        return launchIds[section][row]
    }
    
    func launch(section: Int, row: Int) -> FullLaunch? {
        return launches[launchId(section: section, row: row)]
    }
}
