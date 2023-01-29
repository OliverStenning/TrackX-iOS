//
//  LaunchDetailViewController.swift
//  TrackX
//
//  Created by Oliver Stenning on 29/05/2022.
//

import RaptorKit
import UIKit
import Combine

class LaunchDetailViewController: UIViewController {
    
    //MARK: - ViewController Main Views
    
    private let scrollView = UIScrollView()
    
    private let headerImage: UIImageView = {
        let imageView = UIImageView()
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
    private let coresSectionStackView = CoresSectionStackView()
    private let payloadsSectionStackView = PayloadsSectionStackView()
    private let capsuleSectionStackView = CapsuleSectionStackView()
    private let locationsSectionStackView = LocationsSectionStackView()
    private let linksSectionStackView = LinksSectionStackView()
    
    private var cancellable: AnyCancellable?
    private var animator: UIViewPropertyAnimator?
    
    //MARK: - Properties
    private var fullLaunch: FullLaunch? = nil
    private var showCores: Bool = true
    private var showLocations: Bool = true
    private var showLinks: Bool = true
    
    //MARK: - Initializers
    convenience init(fullLaunch: FullLaunch) {
        self.init()
        
        self.fullLaunch = fullLaunch
        launchSectionStackView.launch = fullLaunch.launch
        rocketSectionStackView.rocket = fullLaunch.rocket
        launchpadSectionStackView.launchpad = fullLaunch.launchpad
        
        if fullLaunch.cores?.count == fullLaunch.launch.cores?.count && fullLaunch.cores?.count == fullLaunch.coreLandpads?.count {
            showCores = true
            coresSectionStackView.configureWith(cores: fullLaunch.cores, launchCores: fullLaunch.launch.cores, landpads: fullLaunch.coreLandpads)
        } else {
            showCores = false
        }
  
        if let launchpad = fullLaunch.launchpad {
            showLocations = true
            locationsSectionStackView.configureWith(launchpad: launchpad)
        } else {
            showLocations = false
        }
        
        if let links = fullLaunch.launch.links {
            showLinks = true
            linksSectionStackView.configureWith(links: links)
        } else {
            showLinks = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        updateViews()
    }
    
    //MARK: - Configuration Functions
    private func configureViews() {
        title = "Launch Info"
        view.backgroundColor = RKAssets.Colors.backgroundSecondary.color
        
        view.addSubview(scrollView)
        scrollView.addSubview(headerImage)
        scrollView.addSubview(headerGradient)
        scrollView.addSubview(infoStack)
        infoStack.addArrangedSubview(launchSectionStackView)
        infoStack.addArrangedSubview(rocketSectionStackView)
        infoStack.addArrangedSubview(launchpadSectionStackView)
        if showCores {
            infoStack.addArrangedSubview(coresSectionStackView)
        }
        if showLocations {
            infoStack.addArrangedSubview(locationsSectionStackView)
        }
        if showLinks {
            infoStack.addArrangedSubview(linksSectionStackView)
        }
    }
    
    private func configureConstraints() {
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
        infoStack.setCustomSpacing(sectionSpacing, after: coresSectionStackView)
        infoStack.setCustomSpacing(sectionSpacing, after: payloadsSectionStackView)
        infoStack.setCustomSpacing(sectionSpacing, after: capsuleSectionStackView)
        infoStack.setCustomSpacing(sectionSpacing, after: locationsSectionStackView)
    }
    
    //MARK: - Update Functions
    func updateViews() {
        if let imageUrl = fullLaunch?.getLaunchImageUrl() {
            cancellable = loadImage(for: imageUrl).sink { [unowned self] image in self.showImage(image: image)}
        } else {
            showImage(image: RKAssets.Images.placeholder.image)
        }
    }
    
    func showImage(image: UIImage?) {
        headerImage.alpha = 0.0
        animator?.stopAnimation(false)
        headerImage.image = image
        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.headerImage.alpha = 1.0
        })
    }
    
    func loadImage(for url: String) -> AnyPublisher<UIImage?, Never> {
        return Just(url)
            .flatMap({ url -> AnyPublisher<UIImage?, Never> in
                let url = URL(string: url)!
                return ImageLoader.shared.loadImage(from: url)
            })
            .eraseToAnyPublisher()
    }
    
}
