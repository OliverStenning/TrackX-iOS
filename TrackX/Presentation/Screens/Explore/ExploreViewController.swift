//
//  ExploreViewController.swift
//  TrackX
//
//  Created by Oliver Stenning on 13/08/2022.
//

import UIKit

class ExploreViewController: UIViewController {
    
    // MARK: - Views
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 12
        return stackView
    }()
    
    private let titleContainer = UIView()
    private let titleView: UILabel = {
        let label = UILabel()
        label.text = "Explore"
//        label.font = R.font.archivoSemiBold(size: 36)
//        label.textColor = R.color.textColor()
        label.textAlignment = .left
        return label
    }()
    
    private let nextLaunchSection: NextLaunchSectionView
    private let photoReelSection = PhotoReelSectionView()
    private let scheduledLaunchesSection: ScheduledLaunchesSectionView
    private let recentLaunchesSection: RecentLaunchesSectionView
    private let rocketsCard = RocketsSectionView()
    private let aboutSection = AboutSectionView()
    private let settingsSection = SettingsSectionView()
    private let footerSection = UIView()
    
    // MARK: - Properties
    private let dataManager: DataManager
    private let launchProvider: LaunchProvider
    
    // MARK: - Initializers
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        self.launchProvider = LaunchProvider(dataManager: dataManager)
        
        self.nextLaunchSection = NextLaunchSectionView(launchProvider: self.launchProvider)
        self.scheduledLaunchesSection = ScheduledLaunchesSectionView(launchProvider: self.launchProvider)
        self.recentLaunchesSection = RecentLaunchesSectionView(launchProvider: self.launchProvider)
        
        super.init(nibName: nil, bundle: nil)
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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - Configuration Functions
    private func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(titleContainer)
        stackView.addArrangedSubview(nextLaunchSection)
        stackView.addArrangedSubview(photoReelSection)
        stackView.addArrangedSubview(scheduledLaunchesSection)
        stackView.addArrangedSubview(recentLaunchesSection)
        stackView.addArrangedSubview(rocketsCard)
        stackView.addArrangedSubview(aboutSection)
        stackView.addArrangedSubview(settingsSection)
        stackView.addArrangedSubview(footerSection)
        titleContainer.addSubview(titleView)
    }
    
    private func configureViews() {
//        title = R.string.localizable.explore()
//        view.backgroundColor = R.color.backgroundColor()
        rocketsCard.isHidden = true

        // Interaction delegates
        nextLaunchSection.delegate = self
        scheduledLaunchesSection.delegate = self
        recentLaunchesSection.delegate = self
    }
    
    private func configureConstraints() {
        let margin: CGFloat = 16
        
        scrollView.anchor(
            top: view.layoutMarginsGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 0)
        )
        
        stackView.anchorWidth(to: scrollView, constant: 0)
        stackView.anchor(
            top: scrollView.topAnchor,
            leading: scrollView.leadingAnchor,
            bottom: scrollView.bottomAnchor,
            trailing: scrollView.trailingAnchor,
            padding: .init(top: margin * 2, left: 0, bottom: 0, right: 0)
        )
        
        titleView.anchor(
            top: titleContainer.topAnchor,
            leading: titleContainer.leadingAnchor,
            bottom: titleContainer.bottomAnchor,
            trailing: titleContainer.trailingAnchor,
            padding: .init(top: 0, left: margin, bottom: 0, right: margin)
        )
        
        footerSection.anchorSize(height: margin)
    }

    private func showLaunchDetailView(with fullLaunch: FullLaunch) {
        let launchDetailVC = LaunchDetailViewController(fullLaunch: fullLaunch)
        navigationController?.pushViewController(launchDetailVC, animated: true)
    }
    
    private func showLaunchTableView(launchType: LaunchType) {
        let launchTableVC = LaunchTableViewController(launchProvider: launchProvider, launchType: launchType)
        navigationController?.pushViewController(launchTableVC, animated: true)
    }
}

extension ExploreViewController: NextLaunchSectionDelegate {
    func nextLaunchSection(_ sectionView: NextLaunchSectionView, launchSelected: FullLaunch) {
        showLaunchDetailView(with: launchSelected)
    }
}

extension ExploreViewController: ScheduledLaunchesSectionDelegate {
    func scheduledLaunchesSection(_ sectionView: ScheduledLaunchesSectionView, didSelectLaunch fullLaunch: FullLaunch) {
        showLaunchDetailView(with: fullLaunch)
    }
    func scheduledLaunchesSection(_ sectionView: ScheduledLaunchesSectionView, didSelectAllLaunches: Bool) {
        showLaunchTableView(launchType: .scheduled)
    }
}

extension ExploreViewController: RecentLaunchesSectionDelegate {
    func recentLaunchesSection(_ recentLaunchesSection: RecentLaunchesSectionView, didSelectLaunch fullLaunch: FullLaunch) {
        showLaunchDetailView(with: fullLaunch)
    }
    func recentLaunchesSection(_ recentLaunchesSection: RecentLaunchesSectionView, didSelectAllLaunches: Bool) {
        showLaunchTableView(launchType: .recent)
    }
}
