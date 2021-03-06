//
//  LaunchViewController.swift
//  TrackX
//
//  Created by Oliver Stenning on 25/03/2022.
//

import UIKit

class LaunchViewController: UIViewController {
    // MARK: - Views

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
        tableView.register(LaunchTablePrimaryCell.self, forCellReuseIdentifier: LaunchCells.launchCellPrimary)
        tableView.register(LaunchTableSecondaryCell.self, forCellReuseIdentifier: LaunchCells.launchCellSecondary)
        tableView.contentInsetAdjustmentBehavior = .never
        return tableView
    }()
    
    let launchRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(named: "AccentColor")
        refreshControl.addTarget(nil, action: #selector(refreshLaunches(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    // MARK: - Properties

    var previousDataSource: LaunchTableDataSource?
    var upcomingDataSource: LaunchTableDataSource?
    var allDataSource: LaunchTableDataSource?
    
    var networkManager: NetworkManager!
    var dataManager: DataManager
    
    // MARK: - Initializers

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        self.dataManager = DataManager(networkManager: networkManager)
        super.init(nibName: nil, bundle: nil)
        
        dataManager.launchDelegate = self
    }
    
    @available(*, unavailable)
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        dataManager.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let index = launchTableView.indexPathForSelectedRow {
            launchTableView.deselectRow(at: index, animated: true)
        }
    }
    
    // MARK: - Configuration Functions

    func configureViews() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        title = "Launches"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .plain, target: self, action: #selector(toggleAscending))
        
        launchTableView.delegate = self
        
        view.addSubview(searchBar)
        view.addSubview(launchTableView)
        view.addSubview(launchTableControl)
        launchTableView.refreshControl = launchRefreshControl
        
        launchRefreshControl.beginRefreshing()
    }
    
    func configureConstraints() {
        launchTableControl.anchor(
            leading: view.layoutMarginsGuide.leadingAnchor,
            bottom: view.layoutMarginsGuide.bottomAnchor,
            trailing: view.layoutMarginsGuide.trailingAnchor,
            padding: .init(top: 0, left: 16, bottom: 16, right: 16)
        )
        launchTableControl.anchorSize(height: 36)
        
        // Disable search bar
//       searchBar.anchor(
//           top: view.layoutMarginsGuide.topAnchor,
//           leading: view.layoutMarginsGuide.leadingAnchor,
//           trailing: view.layoutMarginsGuide.trailingAnchor,
//           padding: .init(top: 0, left: -8, bottom: 0, right: -8)
//       )

        launchTableView.anchor(
            top: view.layoutMarginsGuide.topAnchor,
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
        let dataSource = getCurrentTableSource()
        launchTableView.dataSource = dataSource
        if dataSource != nil {
            launchTableView.reloadData()
            launchTableView.scrollToRow(at: .init(row: 0, section: 0), at: .top, animated: false)
        }
    }
    
    @objc func refreshLaunches(_ sender: Any) {
        dataManager.fetchData()
    }
    
    @objc func toggleAscending() {
        let tableSource = getCurrentTableSource()
        tableSource?.ascending.toggle()
        launchTableView.reloadData()
    }
}

// MARK: - Launch Table View Delegate

extension LaunchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dataSource = getCurrentTableSource() else { return }
        guard let fullLaunch = dataSource.launch(section: indexPath.section, row: indexPath.row) else { return }
        
        let launchDetailVC = LaunchDetailViewController(fullLaunch: fullLaunch)
        navigationController?.pushViewController(launchDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let dataSource = getCurrentTableSource() else { return nil }
        return LaunchTableSectionHeader(text: dataSource.section(at: section))
    }
}

// MARK: - Launch Data Manager Delegate

extension LaunchViewController: LaunchDataManagerDelegate {
    func launchDataManager(_ manager: DataManager, previousLaunchesUpdate: LaunchTableData) {
        previousDataSource = LaunchTableDataSource(launchType: .previous, launchTableData: previousLaunchesUpdate, ascending: false)
    }
    
    func launchDataManager(_ manager: DataManager, upcomingLaunchesUpdate: LaunchTableData) {
        upcomingDataSource = LaunchTableDataSource(launchType: .upcoming, launchTableData: upcomingLaunchesUpdate, ascending: true)
    }
    
    func launchDataManager(_ manager: DataManager, allLaunchesUpdate: LaunchTableData) {
        allDataSource = LaunchTableDataSource(launchType: .all, launchTableData: allLaunchesUpdate, ascending: true)
    }
    
    func launchDataManager(_ manager: DataManager, dataWasUpdated: Bool) {
        switchLaunchTable()
        launchRefreshControl.endRefreshing()
    }
    
    func launchDataManager(_ manager: DataManager, dataFailedToUpDate: String) {
        let ac = UIAlertController(title: "Network Issue", message: "Unable to connect to server. Check your network connection.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(ac, animated: true)
        
        launchRefreshControl.endRefreshing()
    }
}
