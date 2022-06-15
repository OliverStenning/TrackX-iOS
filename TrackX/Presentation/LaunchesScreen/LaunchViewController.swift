//
//  LaunchViewController.swift
//  TrackX
//
//  Created by Oliver Stenning on 25/03/2022.
//

import UIKit
import SwiftUI

class LaunchViewController: UIViewController {
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search launches"
        searchBar.searchTextField.font = UIFont(name: "ArchivoRoman-Medium", size: 16)
        return searchBar
    }()
    
    let launchTableControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Previous", "Upcoming", "All"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(nil, action: #selector(switchLaunchTable), for: .valueChanged)
        segmentedControl.selectedSegmentTintColor = UIColor(named: "AccentColor")
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemGray], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.backgroundColor = UIColor(named: "SecondaryBackgroundColor")
        return segmentedControl
    }()
    
    let launchTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor(named: "BackgroundColor")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(LaunchListPrimaryCell.self, forCellReuseIdentifier: LaunchCells.primaryLaunchCell)
        tableView.register(LaunchListSecondaryCell.self, forCellReuseIdentifier: LaunchCells.secondaryLaunchCell)
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let launchRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(named: "AccentColor")
        refreshControl.addTarget(nil, action: #selector(refreshLaunches(_:)), for: .valueChanged)
        return refreshControl
    }()
    

    
    var previousDataSource: LaunchTableDataSource? = nil
    var upcomingDataSource: LaunchTableDataSource? = nil
    var allDataSource: LaunchTableDataSource? = nil
    
    var networkManager: NetworkManager!
    var dataManager: DataManager
    
    init(networkManager: NetworkManager) {
        self.dataManager = DataManager()
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
        
        dataManager.delegate = self
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        dataManager.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let index = self.launchTableView.indexPathForSelectedRow{
            self.launchTableView.deselectRow(at: index, animated: true)
        }
    }
    
    func setupViews() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        title = "Launches"
        
        launchTableView.delegate = self
        
        view.addSubview(searchBar)
        view.addSubview(launchTableView)
        view.addSubview(launchTableControl)
        launchTableView.refreshControl = launchRefreshControl
        
        launchRefreshControl.beginRefreshing()
    }
    
    func setupConstraints() {
        searchBar.anchor(
            top: view.layoutMarginsGuide.topAnchor,
            leading: view.layoutMarginsGuide.leadingAnchor,
            trailing: view.layoutMarginsGuide.trailingAnchor
        )
        
        launchTableControl.anchor(
            leading: view.layoutMarginsGuide.leadingAnchor,
            bottom: view.layoutMarginsGuide.bottomAnchor,
            trailing: view.layoutMarginsGuide.trailingAnchor,
            padding: .init(top: 0, left: 16, bottom: 24, right: 16)
        )
        
        launchTableView.anchor(
            top: searchBar.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: view.layoutMarginsGuide.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 0)
        )
    }
    
    func getCurrentTableSource() -> LaunchTableDataSource? {
        switch launchTableControl.selectedSegmentIndex {
            case 0: return previousDataSource
            case 1: return upcomingDataSource
            case 2: return allDataSource
            default: return previousDataSource
        }
    }

    @objc func switchLaunchTable() {
        launchTableView.dataSource = getCurrentTableSource()
        launchTableView.contentOffset = CGPoint.zero
        launchTableView.reloadData()
    }
    
    @objc func refreshLaunches(_ sender: Any) {
        dataManager.fetchData()
    }
}

extension LaunchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let dataSource = getCurrentTableSource() else { return }
        guard let fullLaunch = dataSource.launch(section: indexPath.section, row: indexPath.row) else { return }
        
        let launchDetailVC = LaunchDetailViewController(fullLaunch: fullLaunch)
        navigationController?.pushViewController(launchDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let dataSource = getCurrentTableSource() else { return nil }
        return LaunchListSectionHeader(name: dataSource.section(at: section))
    }
    
}

extension LaunchViewController: LaunchDataManagerDelegate {
    
    func launchDataManager(_ manager: DataManager, previousLaunchesUpdate: LaunchTableData) {
        previousDataSource = LaunchTableDataSource(sections: previousLaunchesUpdate.sections,
                                                   launchIds: previousLaunchesUpdate.launchIds,
                                                   launches: previousLaunchesUpdate.fullLaunches)
    }
    
    func launchDataManager(_ manager: DataManager, upcomingLaunchesUpdate: LaunchTableData) {
        upcomingDataSource = LaunchTableDataSource(sections: upcomingLaunchesUpdate.sections,
                                                   launchIds: upcomingLaunchesUpdate.launchIds,
                                                   launches: upcomingLaunchesUpdate.fullLaunches)
    }
    
    func launchDataManager(_ manager: DataManager, allLaunchesUpdate: LaunchTableData) {
        allDataSource = LaunchTableDataSource(sections: allLaunchesUpdate.sections,
                                              launchIds: allLaunchesUpdate.launchIds,
                                              launches: allLaunchesUpdate.fullLaunches)
    }
    
    func launchDataManager(_ manager: DataManager, dataWasUpdated: Bool) {
        switchLaunchTable()
        launchTableView.reloadData()
        launchRefreshControl.endRefreshing()
    }
    
}
