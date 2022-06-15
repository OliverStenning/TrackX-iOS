//
//  LaunchDetailViewController.swift
//  TrackX
//
//  Created by Oliver Stenning on 29/05/2022.
//

import UIKit

class LaunchDetailViewController: UIViewController {
    
    //MARK: - ViewController Main Views
    
    private let scrollView = UIScrollView()
    
    private let headerImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "placeholder_image")
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let headerGradient = GradientView()
    
    private let infoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fill
        stackView.spacing = 16
        return stackView
    }()
    
    //MARK: - Info Stack Sections
    private let launchSectionStackView = LaunchSectionStackView()
    private let rocketSectionStackView = RocketSectionStackView()
    private let launchpadSectionStackView = LaunchpadSectionStaclView()
    
    //MARK: - Initializers
    convenience init(fullLaunch: FullLaunch) {
        self.init()
        
        launchSectionStackView.launch = fullLaunch.launch
        rocketSectionStackView.rocket = fullLaunch.rocket
        launchpadSectionStackView.launchpad = fullLaunch.launchpad
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    //MARK: - Setup Functions
    private func setupViews() {
        title = "Launch Info"
        view.backgroundColor = UIColor(named: "SecondaryBackgroundColor")
        
        view.addSubview(scrollView)
        scrollView.addSubview(headerImage)
        scrollView.addSubview(headerGradient)
        scrollView.addSubview(infoStack)
        infoStack.addArrangedSubview(launchSectionStackView)
        infoStack.addArrangedSubview(rocketSectionStackView)
        infoStack.addArrangedSubview(launchpadSectionStackView)
    }
    
    private func setupConstraints() {
        scrollView.anchor(
            top: view.layoutMarginsGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.layoutMarginsGuide.bottomAnchor,
            trailing: view.trailingAnchor
        )

        headerImage.anchorWidth(to: scrollView)
        headerImage.anchorHeight(to: view, multiplier: 0.5)
        headerImage.anchor(
            top: scrollView.topAnchor,
            leading: scrollView.leadingAnchor,
            trailing: scrollView.trailingAnchor
        )

        headerGradient.anchorHeight(to: headerImage, multiplier: 0.7)
        headerGradient.anchor(
            leading: scrollView.leadingAnchor,
            bottom: headerImage.bottomAnchor,
            trailing: scrollView.trailingAnchor
        )
        
        infoStack.anchor(
            top: headerImage.bottomAnchor,
            leading: scrollView.leadingAnchor,
            bottom: scrollView.bottomAnchor,
            trailing: scrollView.trailingAnchor,
            padding: .init(top: -80, left: 16, bottom: 16, right: 16)
        )
    
        let sectionSpacing: CGFloat = 32
        infoStack.setCustomSpacing(sectionSpacing, after: launchSectionStackView)
        infoStack.setCustomSpacing(sectionSpacing, after: rocketSectionStackView)
        infoStack.setCustomSpacing(sectionSpacing, after: launchpadSectionStackView)
    }
}
