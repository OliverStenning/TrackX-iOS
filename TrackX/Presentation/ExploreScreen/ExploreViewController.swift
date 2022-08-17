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
        label.font = R.font.archivoSemiBold(size: 36)
        label.textColor = R.color.textColor()
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
    private let networkManager: NetworkManager
    private let launchProvider: LaunchProvider
    
    // MARK: - Initializers
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        self.launchProvider = LaunchProvider(networkManager: networkManager)
        
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
        view.backgroundColor = R.color.backgroundColor()
        rocketsCard.isHidden = true
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
}
