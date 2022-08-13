//
//  LaunchViewController.swift
//  TrackX
//
//  Created by Oliver Stenning on 25/03/2022.
//

import UIKit
import SFSafeSymbols

class LaunchViewController: UIViewController {
    
    // MARK: - Views
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = R.string.localizable.searchLaunches()
        searchBar.searchTextField.font = R.font.archivoMedium(size: 16)
        return searchBar
    }()

    let launchTableControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [
            R.string.localizable.previous(),
            R.string.localizable.upcoming(),
            R.string.localizable.all()
        ])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(nil, action: #selector(switchLaunchTable), for: .valueChanged)
        segmentedControl.selectedSegmentTintColor = R.color.accentColor()
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemGray], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.backgroundColor = R.color.secondaryBackgroundColor()
        return segmentedControl
    }()
    
    let launchTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = R.color.backgroundColor()
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(LaunchTablePrimaryCell.self, forCellReuseIdentifier: LaunchCells.launchCellPrimary)
        tableView.register(LaunchTableSecondaryCell.self, forCellReuseIdentifier: LaunchCells.launchCellSecondary)
        tableView.contentInsetAdjustmentBehavior = .never
        return tableView
    }()
    
    let launchRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = R.color.accentColor()
        refreshControl.addTarget(nil, action: #selector(refreshLaunches(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    // MARK: - Properties
    var previousDataSource: LaunchTableDataSource?
    var upcomingDataSource: LaunchTableDataSource?
    var allDataSource: LaunchTableDataSource?
    
    var networkManager: NetworkManager!
    var launchProvider: LaunchProvider
    
    // MARK: - Initializers
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        self.launchProvider = LaunchProvider(networkManager: networkManager)
        super.init(nibName: nil, bundle: nil)
        
        launchProvider.launchProviderDelegate = self
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
        launchProvider.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let index = launchTableView.indexPathForSelectedRow {
            launchTableView.deselectRow(at: index, animated: true)
        }
    }
    
    // MARK: - Configuration Functions
    func configureViews() {
        view.backgroundColor = R.color.backgroundColor()
        
        let titleContainer = UIView()
        let titleImage = R.image.title()
        let titleImageView = UIImageView(image: titleImage)
        titleContainer.addSubview(titleImageView)
        titleImageView.anchorSize(height: 30, width: 100)
        titleImageView.anchor(to: titleContainer, padding: .init(top: 0, left: 0, bottom: 8, right: 0))
        titleImageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = titleContainer
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemSymbol: .arrowUpArrowDown),
            style: .plain,
            target: self,
            action: #selector(toggleAscending)
        )
    
        launchTableView.delegate = self
        
        view.addSubview(searchBar)
        view.addSubview(launchTableView)
        view.addSubview(launchTableControl)
        launchTableView.refreshControl = launchRefreshControl

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
        launchProvider.fetchData()
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

// MARK: - Launch Provider Delegate
extension LaunchViewController: LaunchProviderDelegate {
    func launchProvider(_ provider: LaunchProvider, previousLaunchesUpdate: LaunchTableData) {
        previousDataSource = LaunchTableDataSource(launchType: .previous, launchTableData: previousLaunchesUpdate, ascending: false)
    }
    
    func launchProvider(_ provider: LaunchProvider, upcomingLaunchesUpdate: LaunchTableData) {
        upcomingDataSource = LaunchTableDataSource(launchType: .upcoming, launchTableData: upcomingLaunchesUpdate, ascending: true)
    }
    
    func launchProvider(_ provider: LaunchProvider, allLaunchesUpdate: LaunchTableData) {
        allDataSource = LaunchTableDataSource(launchType: .all, launchTableData: allLaunchesUpdate, ascending: true)
    }
    
    func launchProvider(_ provider: LaunchProvider, dataWasUpdated: Bool) {
        switchLaunchTable()
        launchRefreshControl.endRefreshing()
    }
    
    func launchProvider(_ provider: LaunchProvider, dataFailedToUpDate: String) {
        let ac = UIAlertController(
            title: R.string.localizable.networkIssue(),
            message: R.string.localizable.unableToConnect(),
            preferredStyle: .alert
        )
        ac.addAction(UIAlertAction(title: R.string.localizable.dismiss(), style: .cancel))
        present(ac, animated: true)
        
        launchRefreshControl.endRefreshing()
    }
}
