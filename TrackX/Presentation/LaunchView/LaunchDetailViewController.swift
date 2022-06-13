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
    
    private let headerGradient: GradientView = {
        let gradient = GradientView()
        gradient.topColor = .clear
        gradient.bottomColor = UIColor(named: "BackgroundColor") ?? UIColor.clear
        return gradient
    }()
    
    private let infoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fill
        stackView.spacing = 16
        return stackView
    }()
    
    //MARK: - Launch Section
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Archivo-SemiBold", size: 30)
        label.textColor = UIColor(named: "TextColor")
        label.numberOfLines = 0
        return label
    }()
    
    private let dateStatusStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.fill
        stackView.alignment = .center
        stackView.spacing = 16
        return stackView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "ArchivoRoman-Medium", size: 18)
        label.textColor = UIColor(named: "SecondaryTextColor")
        return label
    }()
    
    private let statusView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 14
        return view
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Archivo-SemiBold", size: 16)
        label.textColor = UIColor(named: "BackgroundColor")
        return label
    }()
    
    private let spacerView: UIView = {
        let view = UIView()
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "RubikRoman-Regular", size: 15)
        label.textColor = UIColor(named: "TextColor")
        label.numberOfLines = 4
        label.isUserInteractionEnabled = true
        return label
    }()
    
    //MARK: - Rocket Section
    
    private let rocketSectionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Archivo-SemiBold", size: 22)
        label.textColor = UIColor(named: "TextColor")
        label.text = "Launch Vehicle"
        return label
    }()
    
    private let rocketName: NameValueView = {
        let view = NameValueView(name: "Name")
        return view
    }()
    
    private let rocketDescription: NameValueView = {
        let view = NameValueView(name: "Description")
        return view
    }()
    
    private let rocketDetails: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.fillEqually
        return stackView
    }()
    
    private let rocketSuccessRate: NameValueView = {
        let view = NameValueView(name: "Success")
        return view
    }()
    
    private let rocketStages: NameValueView = {
        let view = NameValueView(name: "Stages")
        return view
    }()
    
    private let rocketCost: NameValueView = {
        let view = NameValueView(name: "Cost")
        return view
    }()
    
    private let rocketMeasures: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.fillEqually
        return stackView
    }()
    
    private let rocketMass: NameValueView = {
        let view = NameValueView(name: "Mass")
        return view
    }()
    
    private let rocketHeight: NameValueView = {
        let view = NameValueView(name: "Height")
        return view
    }()
    
    private let rocketDiameter: NameValueView = {
        let view = NameValueView(name: "Diameter")
        return view
    }()
  
    //MARK: - Launchpad Section
    
    private let launchpadSectionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Archivo-SemiBold", size: 22)
        label.textColor = UIColor(named: "TextColor")
        label.text = "Launchpad"
        return label
    }()
    
    private let launchpadName: NameValueView = {
        let view = NameValueView(name: "Name")
        return view
    }()
    
    private let launchpadFullName: NameValueView = {
        let view = NameValueView(name: "Full Name")
        return view
    }()
    
    private let launchpadRegion: NameValueView = {
        let view = NameValueView(name: "Region")
        return view
    }()
    
    //MARK: - Data Properties
    
    var descriptionExpanded: Bool = false
    var launch: Launch?
    var rocket: Rocket?
    var launchpad: Launchpad?
    
    convenience init(launch: Launch?, rocket: Rocket?, launchpad: Launchpad?) {
        self.init()
        self.launch = launch
        self.rocket = rocket
        self.launchpad = launchpad
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        configureViews()
    }
    
    //MARK: - Setup Functions
    
    private func setupViews() {
        title = "Launch Info"
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(headerImage)
        scrollView.addSubview(headerGradient)
        scrollView.addSubview(infoStack)
        
        infoStack.addArrangedSubview(nameLabel)
        infoStack.addArrangedSubview(dateStatusStack)
        infoStack.addArrangedSubview(descriptionLabel)
        
        infoStack.addArrangedSubview(rocketSectionLabel)
        infoStack.addArrangedSubview(rocketName)
        infoStack.addArrangedSubview(rocketDescription)
        infoStack.addArrangedSubview(rocketDetails)
        infoStack.addArrangedSubview(rocketMeasures)
        
        infoStack.addArrangedSubview(launchpadSectionLabel)
        infoStack.addArrangedSubview(launchpadName)
        infoStack.addArrangedSubview(launchpadFullName)
        infoStack.addArrangedSubview(launchpadRegion)
        
        dateStatusStack.addArrangedSubview(dateLabel)
        dateStatusStack.addArrangedSubview(statusView)
        dateStatusStack.addArrangedSubview(spacerView)
        statusView.addSubview(statusLabel)
        
        rocketDetails.addArrangedSubview(rocketStages)
        rocketDetails.addArrangedSubview(rocketSuccessRate)
        rocketDetails.addArrangedSubview(rocketCost)
        
        rocketMeasures.addArrangedSubview(rocketMass)
        rocketMeasures.addArrangedSubview(rocketHeight)
        rocketMeasures.addArrangedSubview(rocketDiameter)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapDescription))
        gesture.numberOfTapsRequired = 1
        descriptionLabel.addGestureRecognizer(gesture)
    }
    
    private func setupConstraints() {
        scrollView.anchor(
            top: view.layoutMarginsGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.layoutMarginsGuide.bottomAnchor,
            trailing: view.trailingAnchor
        )
                
        headerImage.anchor(
            top: scrollView.topAnchor,
            leading: scrollView.leadingAnchor,
            trailing: scrollView.trailingAnchor
        )
        headerImage.anchorWidth(to: scrollView)
        headerImage.anchorHeight(to: view, multiplier: 0.5)
        
        headerGradient.anchor(
            leading: scrollView.leadingAnchor,
            bottom: headerImage.bottomAnchor,
            trailing: scrollView.trailingAnchor
        )
        headerGradient.anchorHeight(to: headerImage, multiplier: 0.7)
    
        infoStack.anchor(
            top: headerImage.bottomAnchor,
            leading: scrollView.leadingAnchor,
            bottom: scrollView.bottomAnchor,
            trailing: scrollView.trailingAnchor,
            padding: .init(top: -64, left: 16, bottom: 16, right: 16)
        )
        
        statusView.anchorSize(height: 28)
        statusView.anchorYCenter(to: dateLabel)

        statusLabel.anchor(
            top: statusView.topAnchor,
            leading: statusView.leadingAnchor,
            bottom: statusView.bottomAnchor,
            trailing: statusView.trailingAnchor,
            padding: .init(top: 0, left: 16, bottom: 0, right: 16)
        )
        
        rocketDetails.anchorWidth(to: infoStack)
        rocketMeasures.anchorWidth(to: infoStack)
        
        
        let sectionSpacing: CGFloat = 32
        
        infoStack.setCustomSpacing(16, after: nameLabel)
        infoStack.setCustomSpacing(16, after: dateStatusStack)
        infoStack.setCustomSpacing(sectionSpacing, after: descriptionLabel)
        infoStack.setCustomSpacing(sectionSpacing, after: rocketMeasures)
    }
    
    //MARK: - Configuration Functions
    
    private func configureViews() {
        configureLaunchViews()
        configureRocketViews()
        configureLaunchpadViews()
    }
    
    private func configureLaunchViews() {
        nameLabel.text = launch?.name ?? "Missing"
        dateLabel.text = formatDate(from: launch?.dateUtc ?? "")
        
        if let description = launch?.details {
            descriptionLabel.isHidden = false
            descriptionLabel.text = description
        } else {
            descriptionLabel.isHidden = true
            descriptionLabel.text = ""
        }
        
        if launch?.upcoming ?? false {
            statusView.backgroundColor = UIColor(named: "AccentColor")
            statusLabel.text = "Scheduled"
            statusLabel.textColor = UIColor(named: "BackgroundColor")
        } else if launch?.success ?? false {
            statusView.backgroundColor = .systemGreen
            statusLabel.text = "Success"
            statusLabel.textColor = UIColor(named: "BackgroundColor")
        } else {
            statusView.backgroundColor = .systemRed
            statusLabel.text = "Failed"
            statusLabel.textColor = UIColor(named: "BackgroundColor")
        }
    }
    
    private func configureRocketViews() {
        rocketName.value = rocket?.name ?? "Unknown"
        rocketDescription.value = rocket?.description ?? "Unknown"
        
        if let stages = rocket?.stages {
            rocketStages.value = "\(stages)"
        } else {
            rocketStages.value = "Unknown"
        }
        
        if let successRate = rocket?.successRatePct {
            rocketSuccessRate.value = "\(successRate)%"
        } else {
            rocketSuccessRate.value = "Unknown"
        }
        
        if let cost = rocket?.costPerLaunch {
            rocketCost.value = "$\(cost / 1000000)m"
        } else {
            rocketCost.value = "Unknown"
        }
        
        rocketMass.value = "\((rocket?.mass?.kg ?? 0) / 1000)t"
        rocketMass.value2 = "\((rocket?.mass?.lb ?? 0) / 1000)k lbs"

        rocketHeight.value = "\(rocket?.height?.meters ?? 0)m"
        rocketHeight.value2 = "\(rocket?.height?.feet ?? 0)ft"

        rocketDiameter.value = "\(rocket?.diameter?.meters ?? 0)m"
        rocketDiameter.value2 = "\(rocket?.diameter?.feet ?? 0)ft"
    }
    
    private func configureLaunchpadViews() {
        launchpadName.value = launchpad?.name ?? "Unknown"
        launchpadFullName.value = launchpad?.fullName ?? "Unknown"
        launchpadRegion.value = launchpad?.region ?? "Unknown"
    }
    
    //MARK: - Action Functions
    
    @objc func tapDescription() {
        descriptionLabel.numberOfLines = descriptionExpanded ? 4 : 0
        descriptionExpanded.toggle()
    }
     
}
