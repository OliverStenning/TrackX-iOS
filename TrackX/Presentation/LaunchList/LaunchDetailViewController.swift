//
//  LaunchDetailViewController.swift
//  TrackX
//
//  Created by Oliver Stenning on 29/05/2022.
//

import UIKit

class LaunchDetailViewController: UIViewController {
    
    // UI
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let mainImage: UIImageView = {
        //let image = UIImageView(image: UIImage(named: "placeholder_image"))
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let launchNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let launchDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let launchStatusView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "AccentColor")
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let launchStatusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        label.textColor = UIColor(named: "Background")
        label.text = "Scheduled"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let launchDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 3
        //label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Rocket section components
    
    let rocketSectionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .label
        label.text = "Launch Vehicle"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rocketNameView: NameValueView = {
        let view = NameValueView(nameText: "Name")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let rocketDescriptionView: NameValueView = {
        let view = NameValueView(nameText: "Description")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let rocketStatsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "BackgroundSecondary")
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let rocketStatsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.fillEqually
        stackView.alignment = UIStackView.Alignment.leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let rocketMassStats: StatView = {
        let view = StatView(icon: "scalemass", name: "Mass")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let rocketHeightStats: StatView = {
        let view = StatView(icon: "arrow.up.and.down", name: "Height")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let rocketDiameterStats: StatView = {
        let view = StatView(icon: "arrow.left.and.right", name: "Diameter")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Launchpad section components
    
    let launchpadSectionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .label
        label.text = "Launchpad"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let launchpadNameView: NameValueView = {
        let view = NameValueView(nameText: "Name")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let launchpadRegionView: NameValueView = {
        let view = NameValueView(nameText: "Region")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Data
    var launch: Launch?
    var rocket: Rocket?
    var launchpad: Launchpad?
    
    var descriptionExpanded: Bool = false
    
    convenience init(launch: Launch?, rocket: Rocket?, launchpad: Launchpad?) {
        self.init()
        self.launch = launch
        self.rocket = rocket
        self.launchpad = launchpad
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        configureConstraints()
        configureViews()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapDescription))
        gesture.numberOfTapsRequired = 1
        launchDescriptionLabel.isUserInteractionEnabled = true
        launchDescriptionLabel.addGestureRecognizer(gesture)
    }
    
    func addViews() {
        view.addSubview(scrollView)
        
        [ mainImage, launchNameLabel, launchDateLabel, launchStatusView, launchDescriptionLabel, rocketSectionLabel, rocketNameView, rocketDescriptionView, rocketStatsContainer, launchpadSectionLabel, launchpadNameView, launchpadRegionView].forEach {
            scrollView.addSubview($0)
        }
        
        launchStatusView.addSubview(launchStatusLabel)
        
        rocketStatsContainer.addSubview(rocketStatsStack)
        
        [ rocketMassStats, rocketHeightStats, rocketDiameterStats].forEach {
            rocketStatsStack.addArrangedSubview($0)
        }

    }
    
    func configureConstraints() {
        
        let sectionPadding = UIEdgeInsets(top: 16, left: 24, bottom: 0, right: 24)
        let itemPadding = UIEdgeInsets(top: 8, left: 24, bottom: 0, right: 24)
        
        scrollView.anchor(top: view.layoutMarginsGuide.topAnchor, leading: view.leadingAnchor, bottom: view.layoutMarginsGuide.bottomAnchor, trailing: view.trailingAnchor)

        mainImage.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, trailing: scrollView.trailingAnchor)
        mainImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        mainImage.heightAnchor.constraint(equalTo: mainImage.widthAnchor, multiplier: 0.65).isActive = true
        
        launchNameLabel.anchor(top: mainImage.bottomAnchor, leading: scrollView.leadingAnchor, trailing: scrollView.trailingAnchor, padding: sectionPadding)
        launchDateLabel.anchor(top: launchNameLabel.bottomAnchor, leading: scrollView.leadingAnchor, padding: itemPadding)
        launchStatusView.anchor(leading: launchDateLabel.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
        launchStatusView.centerYAnchor.constraint(equalTo: launchDateLabel.centerYAnchor).isActive = true
        launchStatusView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        launchStatusLabel.anchor(top: launchStatusView.topAnchor, leading: launchStatusView.leadingAnchor, bottom: launchStatusView.bottomAnchor,trailing: launchStatusView.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16))
        launchDescriptionLabel.anchor(top: launchDateLabel.bottomAnchor, leading: scrollView.leadingAnchor, trailing: scrollView.trailingAnchor, padding: itemPadding)
        
        rocketSectionLabel.anchor(top: launchDescriptionLabel.bottomAnchor, leading: scrollView.leadingAnchor, trailing: scrollView.trailingAnchor, padding: sectionPadding)
        rocketNameView.anchor(top: rocketSectionLabel.bottomAnchor, leading: scrollView.leadingAnchor, trailing: scrollView.trailingAnchor, padding: itemPadding)
        rocketDescriptionView.anchor(top: rocketNameView.bottomAnchor, leading: scrollView.leadingAnchor, trailing: scrollView.trailingAnchor, padding: itemPadding)
        rocketStatsContainer.anchor(top: rocketDescriptionView.bottomAnchor, leading: scrollView.leadingAnchor, trailing: scrollView.trailingAnchor, padding: .init(top: 16, left: 24, bottom: 0, right: 24))
        
        rocketStatsStack.anchor(top: rocketStatsContainer.topAnchor, leading: rocketStatsContainer.leadingAnchor, bottom: rocketStatsContainer.bottomAnchor, trailing: rocketStatsContainer.trailingAnchor, padding: .init(top: 16, left: 8, bottom: 16, right: 8))
        
        launchpadSectionLabel.anchor(top: rocketStatsContainer.bottomAnchor, leading: scrollView.leadingAnchor, trailing: scrollView.trailingAnchor, padding: sectionPadding)
        launchpadNameView.anchor(top: launchpadSectionLabel.bottomAnchor, leading: scrollView.leadingAnchor, trailing: scrollView.trailingAnchor, padding: itemPadding)
        launchpadRegionView.anchor(top: launchpadNameView.bottomAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor, padding: .init(top: 8, left: 24, bottom: 16, right: 24))
    
    }
    
    func configureViews() {
        
        // Main View
        view.backgroundColor = UIColor(named: "Background")
        
        // Launch information
        launchNameLabel.text = launch?.name ?? "Missing"
        launchDateLabel.text = "April 9, 2022"
        //launchDateLabel.text = "\(rocket?.name ?? "Unknown") • \(launchpad?.name ?? "Unknown")"
        launchDescriptionLabel.text = launch?.details ?? "No information."
        
        if launch?.upcoming ?? false {
            launchStatusView.backgroundColor = UIColor(named: "AccentColor")
            launchStatusLabel.text = "Scheduled"
        } else if launch?.success ?? false {
            launchStatusView.backgroundColor = .systemGreen
            launchStatusLabel.text = "Success"
        } else {
            launchStatusView.backgroundColor = .systemRed
            launchStatusLabel.text = "Failed"
        }
        
        rocketNameView.valueLabel.text = rocket?.name ?? "Unknown"
        rocketDescriptionView.valueLabel.text = rocket?.description ?? "Unknown"
        
        launchpadNameView.valueLabel.text = launchpad?.fullName ?? "Unknown"
        launchpadRegionView.valueLabel.text = launchpad?.region ?? "Unknown"
        
        rocketMassStats.value1.text = "\((rocket?.mass?.kg ?? 0) / 1000)t"
        rocketMassStats.value2.text = "\((rocket?.mass?.lb ?? 0) / 1000)k lbs"
        
        rocketHeightStats.value1.text = "\(rocket?.height?.meters ?? 0)m"
        rocketHeightStats.value2.text = "\(rocket?.height?.feet ?? 0)ft"
        
        rocketDiameterStats.value1.text = "\(rocket?.diameter?.meters ?? 0)m"
        rocketDiameterStats.value2.text = "\(rocket?.diameter?.feet ?? 0)ft"
        
        if let imageUrls = launch?.links?.flickr?.original {
            if !imageUrls.isEmpty {
                mainImage.image = UIImage(named: "placeholder_image")
//                mainImage.downloaded(from: imageUrls[0])
//                print(imageUrls[0])
            } else {
                mainImage.image = UIImage(named: "placeholder_image")
            }

        }
    }
    
    @objc func tapDescription() {
        if descriptionExpanded {
            launchDescriptionLabel.numberOfLines = 3
            descriptionExpanded.toggle()
        } else {
            launchDescriptionLabel.numberOfLines = 0
            descriptionExpanded.toggle()
        }
        
    }
    

     
}
