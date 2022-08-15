//
//  NextLaunchCardView.swift
//  TrackX
//
//  Created by Oliver Stenning on 13/08/2022.
//

import UIKit

class NextLaunchSectionView: UIView {
    
    //MARK: - Views
    private let card = UIView()
    
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
        label.font = R.font.archivoBold(size: 14)
        label.textColor = R.color.secondaryTextColor()
        return label
    }()
    private let launchpadLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.archivoBold(size: 14)
        label.textColor = R.color.secondaryTextColor()
        return label
    }()
    private let countdownView = CountdownView()
    
    //MARK: - Properties
    let launchProvider: LaunchProvider
    
    var fullLaunch: FullLaunch? {
        didSet {
            updateInformation()
        }
    }
    
    var highlighted: Bool = false {
        didSet {
            animateHighlighted()
        }
    }
    var animating: Bool = false
    
    //MARK: - Initializers
    init(launchProvider: LaunchProvider) {
        self.launchProvider = launchProvider
        super.init(frame: .zero)
        configureViews()
        configureConstraints()

        launchProvider.fetchNextLaunch()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration Functions
    private func configureViews() {
        card.backgroundColor = R.color.secondaryBackgroundColor()
        card.layer.cornerRadius = 16
        card.layer.masksToBounds = true
        
        addSubview(card)
        card.addSubview(containerStack)
        
        containerStack.addArrangedSubview(infoContainer)
        containerStack.addArrangedSubview(countdownView)
        
        infoContainer.addSubview(launchLabel)
        infoContainer.addSubview(rocketLabel)
        infoContainer.addSubview(launchpadLabel)
        
        self.isUserInteractionEnabled = true
        self.launchProvider.nextLaunchDelegate = self
    }
    
    private func configureConstraints() {
        let margin: CGFloat = 16
        let padding: CGFloat = 16
        
        card.anchor(
            top: self.topAnchor,
            leading: self.leadingAnchor,
            bottom: self.bottomAnchor,
            trailing: self.trailingAnchor,
            padding: .init(top: 0, left: margin, bottom: 0, right: margin)
        )
        
        containerStack.anchor(
            top: card.topAnchor,
            leading: card.leadingAnchor,
            bottom: card.bottomAnchor,
            trailing: card.trailingAnchor,
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
            rocketLabel.text = fullLaunch.rocket?.name ?? "Unknown"
            launchpadLabel.text = fullLaunch.launchpad?.name ?? "Unknown"
            
            countdownView.launchDate = Dates.dateFromISO8601(fullLaunch.launch.dateUtc)
        }

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        highlighted = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        highlighted = false
        //TODO: show next launch view
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        highlighted = false
    }
    
    func animateHighlighted() {
        if highlighted {
            animating = true
            pressViewAnimation { _ in
                if !self.highlighted {
                    self.releaseViewAnimation()
                }
                self.animating = false
            }
        } else {
            if !animating {
                releaseViewAnimation()
            }
        }
    }
    
    private func pressViewAnimation(completion: ((Bool) -> Void)?) {
        UIView.animate(
            withDuration: 0.05,
            delay: 0,
            options: .curveEaseInOut,
            animations: { self.transform = CGAffineTransform(scaleX: 0.975, y: 0.975) },
            completion: completion
        )
    }
    
    private func releaseViewAnimation() {
        UIView.animate(
            withDuration: 0.05,
            delay: 0,
            options: .curveEaseInOut,
            animations: { self.transform = CGAffineTransform.identity },
            completion: nil
        )
    }
}

// MARK: - Launch Provider Delegate
extension NextLaunchSectionView: NextLaunchDelegate {
    func launchProvider(_ provider: LaunchProvider, nextLaunchUpdate: FullLaunch) {
        self.fullLaunch = nextLaunchUpdate
    }
}

