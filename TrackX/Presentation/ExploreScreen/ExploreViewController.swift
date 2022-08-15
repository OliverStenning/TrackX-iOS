//
//  ExploreViewController.swift
//  TrackX
//
//  Created by Oliver Stenning on 13/08/2022.
//

import UIKit

class ExploreViewController: UIViewController {
    
    // MARK: - Views
    private let scrollView = UIScrollView()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 24
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
    private let scheduledLaunchesSection: ScheduledLaunchesSectionView
    private let recentLaunchesSection: RecentLaunchesSectionView
    private let rocketsCard = RocketsSectionView()
    
    // MARK: - Properties
    let networkManager: NetworkManager
    let launchProvider: LaunchProvider
    
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
        configureViews()
        configureConstraints()
    }
    
    // MARK: - Configuration Functions
    func configureViews() {
        view.backgroundColor = R.color.backgroundColor()
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(titleContainer)
        titleContainer.addSubview(titleView)
        stackView.addArrangedSubview(nextLaunchSection)
        stackView.addArrangedSubview(scheduledLaunchesSection)
        stackView.addArrangedSubview(recentLaunchesSection)
//        stackView.addArrangedSubview(rocketsCard)
    }
    
    func configureConstraints() {
        let padding: CGFloat = 16
        
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
            padding: .init(top: 32, left: 0, bottom: 0, right: 0)
        )
        
        titleView.anchor(
            top: titleContainer.topAnchor,
            leading: titleContainer.leadingAnchor,
            bottom: titleContainer.bottomAnchor,
            trailing: titleContainer.trailingAnchor,
            padding: .init(top: 0, left: padding, bottom: 0, right: padding)
        )
        
        nextLaunchSection.anchorWidth(to: stackView)
        
        scheduledLaunchesSection.anchorWidth(to: stackView)
        scheduledLaunchesSection.anchorSize(height: 180)
        
        recentLaunchesSection.anchorWidth(to: stackView)
        recentLaunchesSection.anchorSize(height: 240)
        
//        rocketsCard.anchorWidth(to: stackView)
//        rocketsCard.anchorSize(height: 400)
    }
}
