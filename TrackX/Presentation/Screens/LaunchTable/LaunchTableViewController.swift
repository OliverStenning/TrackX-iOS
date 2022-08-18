//
//  LaunchTableViewController.swift
//  TrackX
//
//  Created by Oliver Stenning on 18/08/2022.
//

import UIKit
import SFSafeSymbols

class LaunchTableViewController: UIViewController {
    
    // MARK: - Views
    let launchTableControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [
            R.string.localizable.scheduled(),
            R.string.localizable.recent(),
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
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tableView.register(RecentLaunchTableCell.self, forCellReuseIdentifier: LaunchCells.recent)
        tableView.register(ScheduledLaunchTableCell.self, forCellReuseIdentifier: LaunchCells.scheduled)
        tableView.contentInsetAdjustmentBehavior = .never
        return tableView
    }()
    
    // MARK: - Properties
    var recentDataSource: LaunchTableDataSource?
    var scheduledDataSource: LaunchTableDataSource?
    var allDataSource: LaunchTableDataSource?
    
    var launchProvider: LaunchProvider
    
    // MARK: - Initializers
    init(launchProvider: LaunchProvider, launchType: LaunchType) {
        self.launchProvider = launchProvider
        switch launchType {
            case .scheduled:
                launchTableControl.selectedSegmentIndex = 0
            case .recent:
                launchTableControl.selectedSegmentIndex = 1
            case .all:
                launchTableControl.selectedSegmentIndex = 2
        }
        super.init(nibName: nil, bundle: nil)
        launchProvider.launchTableDelegate = self
    }
    
    @available(*, unavailable)
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        configureViews()
        configureConstraints()
        launchProvider.fetchLaunchTableData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let index = launchTableView.indexPathForSelectedRow {
            launchTableView.deselectRow(at: index, animated: true)
        }
    }
    
    // MARK: - Configuration Functions
    private func addViews() {
        view.addSubview(launchTableView)
        view.addSubview(launchTableControl)
    }
    
    func configureViews() {
        title = R.string.localizable.launches()
        view.backgroundColor = R.color.backgroundColor()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemSymbol: .arrowUpArrowDown),
            style: .plain,
            target: self,
            action: #selector(toggleAscending)
        )
    
        launchTableView.delegate = self
    }
    
    func configureConstraints() {
        launchTableControl.anchor(
            leading: view.layoutMarginsGuide.leadingAnchor,
            bottom: view.layoutMarginsGuide.bottomAnchor,
            trailing: view.layoutMarginsGuide.trailingAnchor,
            padding: .init(top: 0, left: 16, bottom: 16, right: 16)
        )
        launchTableControl.anchorSize(height: 36)
        
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
            case 0: return scheduledDataSource
            case 1: return recentDataSource
            case 2: return allDataSource
            default: return scheduledDataSource
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
    
    @objc func toggleAscending() {
        let tableSource = getCurrentTableSource()
        tableSource?.ascending.toggle()
        launchTableView.reloadData()
    }
}

// MARK: - Launch Table View Delegate
extension LaunchTableViewController: UITableViewDelegate {
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
extension LaunchTableViewController: LaunchTableDelegate {
    func launchProvider(_ provider: LaunchProvider, scheduledLaunchesUpdate: LaunchTableData) {
        scheduledDataSource = LaunchTableDataSource(launchType: .scheduled, launchTableData: scheduledLaunchesUpdate, ascending: true)
    }
    
    func launchProvider(_ provider: LaunchProvider, recentLaunchesUpdate: LaunchTableData) {
        recentDataSource = LaunchTableDataSource(launchType: .recent, launchTableData: recentLaunchesUpdate, ascending: false)
    }
    
    func launchProvider(_ provider: LaunchProvider, allLaunchesUpdate: LaunchTableData) {
        allDataSource = LaunchTableDataSource(launchType: .all, launchTableData: allLaunchesUpdate, ascending: true)
    }
    
    func launchProvider(_ provider: LaunchProvider, dataWasUpdated: Bool) {
        switchLaunchTable()
    }
    
    func launchProvider(_ provider: LaunchProvider, dataFailedToUpDate: String) {
        let ac = UIAlertController(
            title: R.string.localizable.networkIssue(),
            message: R.string.localizable.unableToConnect(),
            preferredStyle: .alert
        )
        ac.addAction(UIAlertAction(title: R.string.localizable.dismiss(), style: .cancel))
        present(ac, animated: true)
    }
}

