//
//  LaunchListDataSource.swift
//  TrackX
//
//  Created by Oliver Stenning on 14/06/2022.
//

import UIKit

struct LaunchCells {
    static let primaryLaunchCell = "PrimaryLaunchCell"
    static let secondaryLaunchCell = "SecondaryLaunchCell"
}

class LaunchTableDataSource: NSObject, UITableViewDataSource {
    
    var sections: [String]
    var launchIds: [[String]]
    var launches: [String: FullLaunch]
    
    init(sections: [String], launchIds: [[String]], launches: [String: FullLaunch]) {
        self.sections = sections
        self.launchIds = launchIds
        self.launches = launches
    }
    
    func updateData(sections: [String], launchIds: [[String]], launches: [String: FullLaunch]) {
        self.sections = sections
        self.launchIds = launchIds
        self.launches = launches
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launchIds[section].count
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LaunchCells.secondaryLaunchCell, for: indexPath) as! LaunchListSecondaryCell
        cell.setFullLaunch(launches[launchIds[indexPath.section][indexPath.row]])
        return cell
    }

    
    func section(at index: Int) -> String {
        return sections[index]
    }
    
    func launchId(section: Int, row: Int) -> String {
        return launchIds[section][row]
    }
    
    func launch(id: String) -> FullLaunch? {
        return launches[id]
    }
    
    func launch(section: Int, row: Int) -> FullLaunch? {
        return launches[launchId(section: section, row: row)]
    }
}
