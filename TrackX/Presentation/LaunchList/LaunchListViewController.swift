//
//  ViewController.swift
//  TrackX
//
//  Created by Oliver Stenning on 25/03/2022.
//

import UIKit

class LaunchListViewController: UIViewController {
  
    // UI
    var nextLaunchView = NextLaunchView()
    var launchTableView = UITableView()
    
    let nextLaunchLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .label
        label.text = "Upcoming"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let launchTableLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .label
        label.text = "Launches"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let launchTableControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Previous", "Upcoming", "All"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(nil, action: #selector(switchLaunchTable), for: .valueChanged)
        segmentedControl.selectedSegmentTintColor = UIColor(named: "AccentColor")
        
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.systemGray
            ], for: .normal)

        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.white
            ], for: .selected)
        
        segmentedControl.backgroundColor = UIColor(named: "BackgroundSecondary")
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    struct Cells {
        static let launchCell = "LaunchCell"
    }
    
    // Data
    var allLaunches: [Launch] = []
    var upcomingLaunches: [Launch] = []
    var previousLaunches: [Launch] = []
    var tableLaunches: [Launch] = []
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
        
        view.backgroundColor = UIColor(named: "Background")
        title = "TrackX"
        
        /*
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        titleLabel.textColor = UIColor.label
        titleLabel.text = "TrackX"
        navigationItem.titleView = titleLabel
        */
         
        let networkGroup = DispatchGroup()

        networkGroup.enter()
        networkManager.getLaunches() { launches, error in
            self.allLaunches = launches ?? []
            self.allLaunches.sort() {
                $0.dateUnix > $1.dateUnix
            }
            self.allLaunches.forEach() { launch in
                if launch.upcoming {
                    self.upcomingLaunches.append(launch)
                } else {
                    self.previousLaunches.append(launch)
                }
            }
            
            self.upcomingLaunches.reverse()

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
            
            if let nextLaunch = self.upcomingLaunches.first {
                self.nextLaunchView.set(
                    launch: nextLaunch,
                    rocket: self.rockets[nextLaunch.rocket ?? ""],
                    launchpad: self.launchpads[nextLaunch.launchpad ?? ""]
                )
            }
            
        }
        
        configureNextLaunchView()
        configureTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let index = self.launchTableView.indexPathForSelectedRow{
            self.launchTableView.deselectRow(at: index, animated: true)
        }
    }
    
    func configureNextLaunchView() {
        view.addSubview(nextLaunchLabel)
        view.addSubview(nextLaunchView)
        
        // Constraints
        NSLayoutConstraint.activate([
            nextLaunchLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 12),
            nextLaunchLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            nextLaunchLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
        
        nextLaunchView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextLaunchView.topAnchor.constraint(equalTo: nextLaunchLabel.bottomAnchor, constant: 12),
            nextLaunchView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            nextLaunchView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    func configureTableView() {
        view.addSubview(launchTableLabel)
        view.addSubview(launchTableControl)
        view.addSubview(launchTableView)

        launchTableView.delegate = self
        launchTableView.dataSource = self
        
        launchTableView.estimatedRowHeight = 100
        launchTableView.rowHeight = UITableView.automaticDimension
        launchTableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        launchTableView.register(LaunchListCell.self, forCellReuseIdentifier: Cells.launchCell)
        launchTableView.backgroundColor = UIColor(named: "BackgroundSecondary")
        launchTableView.layer.cornerRadius = 12

        // Constraints
        NSLayoutConstraint.activate([
            launchTableLabel.topAnchor.constraint(equalTo: nextLaunchView.bottomAnchor, constant: 24),
            launchTableLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            launchTableControl.topAnchor.constraint(equalTo: launchTableLabel.bottomAnchor, constant: 8),
            launchTableControl.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            launchTableControl.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
         
        launchTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            launchTableView.topAnchor.constraint(equalTo: launchTableControl.bottomAnchor, constant: 12),
            launchTableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            launchTableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            launchTableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
        
    }

    @objc func switchLaunchTable() {
        switch launchTableControl.selectedSegmentIndex {
        case 0:
            tableLaunches = previousLaunches
        case 1:
            tableLaunches = upcomingLaunches
        case 2:
            tableLaunches = allLaunches
        default:
            tableLaunches = previousLaunches
        }
        launchTableView.reloadData()
    }
    
}

extension LaunchListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableLaunches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = launchTableView.dequeueReusableCell(withIdentifier: Cells.launchCell) as! LaunchListCell
        let launch = tableLaunches[indexPath.row]
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = LaunchDetailViewController(
            launch: tableLaunches[indexPath.row],
            rocket: rockets[tableLaunches[indexPath.row].rocket ?? ""] ?? nil,
            launchpad: launchpads[tableLaunches[indexPath.row].launchpad ?? ""] ?? nil
        )

        navigationController?.pushViewController(detailView, animated: true)
    }
    
}
