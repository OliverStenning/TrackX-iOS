//
//  NextLaunchCardView.swift
//  TrackX
//
//  Created by Oliver Stenning on 13/08/2022.
//

import RaptorKit
import UIKit

class NextLaunchSectionView: UIView {
    
    //MARK: - Views
    private let cardView = UIView()
    
    private let containerStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let infoContainer = UIView()
    private let launchLabel = AccentHeadingView(size: .h4)
    
    private let rocketLabel: UILabel = {
        let label = UILabel()
        label.font = RKFonts.Archivo.bold.font(size: 14)
        label.textColor = RKAssets.Colors.textSecondary.color
        return label
    }()
    
    private let launchpadLabel: UILabel = {
        let label = UILabel()
        label.font = RKFonts.Archivo.bold.font(size: 14)
        label.textColor = RKAssets.Colors.textSecondary.color
        return label
    }()
    
    private let countdownView = CountdownView()
    
    //MARK: - Properties
    private let launchProvider: LaunchProvider
    private var fullLaunch: FullLaunch? {
        didSet {
            updateInformation()
        }
    }
    var delegate: NextLaunchSectionDelegate?
    
    //MARK: - Initializers
    init(launchProvider: LaunchProvider) {
        self.launchProvider = launchProvider
        super.init(frame: .zero)
        addViews()
        configureViews()
        configureConstraints()

        launchProvider.fetchNextLaunch()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration Functions
    private func addViews() {
        addSubview(cardView)
        cardView.addSubview(containerStack)
        
        containerStack.addArrangedSubview(infoContainer)
        containerStack.addArrangedSubview(countdownView)
        
        infoContainer.addSubview(launchLabel)
        infoContainer.addSubview(rocketLabel)
        infoContainer.addSubview(launchpadLabel)
    }
    
    private func configureViews() {
        cardView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(pressNextLaunch))
        gesture.numberOfTapsRequired = 1
        cardView.addGestureRecognizer(gesture)
        
        cardView.backgroundColor = RKAssets.Colors.backgroundSecondary.color
        cardView.layer.cornerRadius = 16
        cardView.layer.masksToBounds = true
        self.isUserInteractionEnabled = true
        self.launchProvider.nextLaunchDelegate = self
    }
    
    private func configureConstraints() {
        let margin: CGFloat = 16
        let padding: CGFloat = 16
        
        cardView.anchor(
            top: self.topAnchor,
            leading: self.leadingAnchor,
            bottom: self.bottomAnchor,
            trailing: self.trailingAnchor,
            padding: .init(top: margin, left: margin, bottom: 0, right: margin)
        )
        
        containerStack.anchor(
            top: cardView.topAnchor,
            leading: cardView.leadingAnchor,
            bottom: cardView.bottomAnchor,
            trailing: cardView.trailingAnchor,
            padding: .init(top: padding, left: padding, bottom: padding, right: padding)
        )
        
        launchLabel.anchor(
            top: infoContainer.topAnchor,
            leading: infoContainer.leadingAnchor,
            trailing: infoContainer.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: padding)
        )
        
        rocketLabel.anchor(
            top: launchLabel.bottomAnchor,
            leading: infoContainer.leadingAnchor,
            padding: .init(top: padding / 2, left: 0, bottom: 0, right: 0)
        )

        launchpadLabel.anchor(
            top: rocketLabel.bottomAnchor,
            leading: infoContainer.leadingAnchor,
            bottom: infoContainer.bottomAnchor,
            padding: .init(top: padding / 4, left: 0, bottom: 0, right: 0)
        )
    }
    
    //MARK: - Update Functions
    private func updateInformation() {
        if let fullLaunch = fullLaunch {
            launchLabel.text = fullLaunch.launch.name
//            rocketLabel.text = fullLaunch.rocket?.name ?? R.string.localizable.unknown()
//            launchpadLabel.text = fullLaunch.launchpad?.name ?? R.string.localizable.unknown()
            
            countdownView.launchDate = Dates.dateFromISO8601(fullLaunch.launch.dateUtc)
        }
    }
    
    //MARK: - Interaction Functions
    @objc private func pressNextLaunch() {
        if let delegate = delegate, let fullLaunch = fullLaunch {
            cardView.springAnimate()
            delegate.nextLaunchSection(self, launchSelected: fullLaunch)
        }
    }
}

// MARK: - Launch Provider Delegate
extension NextLaunchSectionView: NextLaunchDelegate {
    func launchProvider(_ provider: LaunchProvider, nextLaunchUpdate: FullLaunch) {
        self.fullLaunch = nextLaunchUpdate
    }
}

//MARK: - Next Launch Delegate
protocol NextLaunchSectionDelegate {
    func nextLaunchSection(_ section: NextLaunchSectionView, launchSelected: FullLaunch)
}
