//
//  LaunchViewController.swift
//  TrackX
//
//  Created by Oliver Stenning on 25/03/2022.
//

import UIKit
import SwiftUI

class LaunchViewController: UIViewController {
    
    let launchTableControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Previous", "Upcoming"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(nil, action: #selector(switchLaunchTable), for: .valueChanged)
        segmentedControl.selectedSegmentTintColor = UIColor(named: "AccentColor")
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemGray], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    let launchTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor(named: "Background")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(LaunchListPrimaryCell.self, forCellReuseIdentifier: LaunchCells.launchCellPrimary)
        tableView.register(LaunchListSecondaryCell.self, forCellReuseIdentifier: LaunchCells.launchCell)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let launchRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(named: "AccentColor")
        refreshControl.addTarget(nil, action: #selector(refreshLaunches(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    let sectionHeader: UIView = {
        let view = UIView()
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .label
        view.addSubview(label)
        label.anchor(to: view, padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        return view
    }()
    
    struct LaunchCells {
        static let launchCell = "LaunchCell"
        static let launchCellPrimary = "LaunchCellPrimary"
    }
    
    // Table view data
    var previousLaunchSections: [String] = []
    var previousLaunchIds: [[String]] = [[]]
    var upcomingLaunchSections: [String] = []
    var upcomingLaunchIds: [[String]] = [[]]
    
    // Data
    var launches: [String: Launch] = [:]
    var rockets: [String: Rocket] = [:]
    var launchpads: [String: Launchpad] = [:]
    var landpads: [String: Landpad] = [:]
    var cores: [String: Core] = [:]
    var capsules: [String: Capsule] = [:]
    var payloads: [String: Payload] = [:]
    
    var networkManager: NetworkManager!
    
    init(networkManager: NetworkManager) {
        super.init(nibName: nil, bundle: nil)
        self.networkManager = networkManager
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        startNetworkRequests()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let index = self.launchTableView.indexPathForSelectedRow{
            self.launchTableView.deselectRow(at: index, animated: true)
        }
    }
    
    func setupViews() {
        view.backgroundColor = UIColor(named: "Background")
        title = "TrackX"
        
        launchTableView.delegate = self
        launchTableView.dataSource = self
        
        view.addSubview(launchTableControl)
        view.addSubview(launchTableView)
        launchTableView.refreshControl = launchRefreshControl
        
    }
    
    func setupConstraints() {
        launchTableControl.anchor(
            top: view.layoutMarginsGuide.topAnchor,
            leading: view.layoutMarginsGuide.leadingAnchor,
            trailing: view.layoutMarginsGuide.trailingAnchor
        )
        
        launchTableView.anchor(
            top: launchTableControl.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: view.layoutMarginsGuide.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 8, left: 0, bottom: 0, right: 0)
        )
    }
    
    func startNetworkRequests() {
        let networkGroup = DispatchGroup()

        networkGroup.enter()
        networkManager.getLaunches() { launches, error in
            
            // If launches array is returned
            if let launches = launches {
                
                // Sort the array based on launch date
                let sortedLaunches = launches.sorted() {
                    $0.dateUnix > $1.dateUnix
                }
                
                // Append dictionary of launches with data
                self.launches = [:]
                sortedLaunches.forEach { launch in
                    self.launches[launch.id] = launch
                }
                
                // Split into previous and upcoming launches
                var previousLaunches: [Launch] = []
                var upcomingLaunches: [Launch] = []
                sortedLaunches.forEach() { launch in
                    if launch.upcoming {
                        upcomingLaunches.append(launch)
                    } else {
                        previousLaunches.append(launch)
                    }
                }
                upcomingLaunches.reverse()
                
                // Split launches into sections based on launch dates
                let previousTableData = self.splitLaunchesIntoSections(launches: previousLaunches)
                self.previousLaunchSections = previousTableData.sectionNames
                self.previousLaunchSections[0] = "Latest"
                self.previousLaunchIds = previousTableData.launchIds
                
                let upcomingTableData = self.splitLaunchesIntoSections(launches: upcomingLaunches)
                self.upcomingLaunchSections = upcomingTableData.sectionNames
                self.upcomingLaunchSections[0] = "Next"
                self.upcomingLaunchIds = upcomingTableData.launchIds
                
            }
            
            networkGroup.leave()
        }
        
        networkGroup.enter()
        networkManager.getRockets() { rockets, error in
            rockets?.forEach() { rocket in
                self.rockets[rocket.id] = rocket
            }
            networkGroup.leave()
        }

        networkGroup.enter()
        networkManager.getLaunchpads() { launchpads, error in
            launchpads?.forEach() { launchpad in
                self.launchpads[launchpad.id] = launchpad
            }
            networkGroup.leave()
        }

        networkGroup.enter()
        networkManager.getPayloads() { payloads, error in
            payloads?.forEach() { payload in
                self.payloads[payload.id] = payload
            }
            networkGroup.leave()
        }
        
        networkGroup.notify(queue: .main) {
            self.switchLaunchTable()
            self.launchRefreshControl.endRefreshing()
        }
    }
    
    func splitLaunchesIntoSections(launches: [Launch]) -> (sectionNames: [String], launchIds: [[String]]) {
        
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

    @objc func switchLaunchTable() {
        self.launchTableView.contentOffset = CGPoint.zero
        self.launchTableView.reloadData()
    }
    
    @objc func refreshLaunches(_ sender: Any) {
        startNetworkRequests()
    }
}

extension LaunchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if launchTableControl.selectedSegmentIndex == 0 {
            return previousLaunchSections.count
        } else {
            return upcomingLaunchSections.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if launchTableControl.selectedSegmentIndex == 0 {
            return previousLaunchIds[section].count
        } else {
            return upcomingLaunchIds[section].count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = LaunchListSectionHeader()
        if launchTableControl.selectedSegmentIndex == 0 {
            header.name = previousLaunchSections[section]
        } else {
            header.name = upcomingLaunchSections[section]
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = launchTableView.dequeueReusableCell(withIdentifier: LaunchCells.launchCellPrimary) as! LaunchListPrimaryCell
            if launchTableControl.selectedSegmentIndex == 0 {
                if let launch = launches[previousLaunchIds[indexPath.section][indexPath.row]] {
                    cell.set(
                        launch: launch,
                        rocket: rockets[launch.rocket ?? ""],
                        launchpad: launchpads[launch.launchpad ?? ""]
                    )
                }
            } else {
                if let launch = launches[upcomingLaunchIds[indexPath.section][indexPath.row]] {
                    cell.set(
                        launch: launch,
                        rocket: rockets[launch.rocket ?? ""],
                        launchpad: launchpads[launch.launchpad ?? ""]
                    )
                }
            }
            return cell
        } else {
            let cell = launchTableView.dequeueReusableCell(withIdentifier: LaunchCells.launchCell) as! LaunchListSecondaryCell
            if launchTableControl.selectedSegmentIndex == 0 {
                if let launch = launches[previousLaunchIds[indexPath.section][indexPath.row]] {
                    var launchPayloads: [Payload] = []
                    
                    launch.payloads?.forEach() { payloadId in
                        if let launchPayload = payloads[payloadId] {
                            launchPayloads.append(launchPayload)
                        }
                    }
                    
                    cell.set(
                        launch: launch,
                        rocket: rockets[launch.rocket ?? ""],
                        launchpad: launchpads[launch.launchpad ?? ""],
                        payloads: launchPayloads.isEmpty ? nil : launchPayloads
                    )
                }
            } else {
                if let launch = launches[upcomingLaunchIds[indexPath.section][indexPath.row]] {
                    var launchPayloads: [Payload] = []
                    
                    launch.payloads?.forEach() { payloadId in
                        if let launchPayload = payloads[payloadId] {
                            launchPayloads.append(launchPayload)
                        }
                    }
                    
                    cell.set(
                        launch: launch,
                        rocket: rockets[launch.rocket ?? ""],
                        launchpad: launchpads[launch.launchpad ?? ""],
                        payloads: launchPayloads.isEmpty ? nil : launchPayloads
                    )
                }
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if launchTableControl.selectedSegmentIndex == 0 {
            if let launch = launches[previousLaunchIds[indexPath.section][indexPath.row]] {
                let detailView = LaunchDetailViewController(
                    launch: launch,
                    rocket: rockets[launch.rocket ?? ""] ?? nil,
                    launchpad: launchpads[launch.launchpad ?? ""] ?? nil
                )
                navigationController?.pushViewController(detailView, animated: true)
            }
        } else {
            if let launch = launches[upcomingLaunchIds[indexPath.section][indexPath.row]] {
                let detailView = LaunchDetailViewController(
                    launch: launch,
                    rocket: rockets[launch.rocket ?? ""] ?? nil,
                    launchpad: launchpads[launch.launchpad ?? ""] ?? nil
                )
                navigationController?.pushViewController(detailView, animated: true)
            }
        }
        

    }
    
}
