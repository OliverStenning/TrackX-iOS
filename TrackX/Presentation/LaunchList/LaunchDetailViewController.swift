//
//  LaunchDetailViewController.swift
//  TrackX
//
//  Created by Oliver Stenning on 29/05/2022.
//

import UIKit

class LaunchDetailViewController: UIViewController {
    
    // UI
    let mainImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "placeholder_image"))
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let launchNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let launchSubheadingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .secondaryLabel
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
        setupLayout()
        configureViews()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapDescription))
        gesture.numberOfTapsRequired = 1
        launchDescriptionLabel.isUserInteractionEnabled = true
        launchDescriptionLabel.addGestureRecognizer(gesture)
    }
    
    func addViews() {
        view.addSubview(mainImage)
        view.addSubview(launchNameLabel)
        view.addSubview(launchSubheadingLabel)
        view.addSubview(launchDescriptionLabel)
    }
    
    func setupLayout() {
        
        NSLayoutConstraint.activate([
            mainImage.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            mainImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainImage.heightAnchor.constraint(equalTo: mainImage.widthAnchor, multiplier: 0.75)
        ])
        
        NSLayoutConstraint.activate([
            launchNameLabel.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 20),
            launchNameLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 8),
            launchNameLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            launchSubheadingLabel.topAnchor.constraint(equalTo: launchNameLabel.bottomAnchor, constant: 12),
            launchSubheadingLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 8),
            launchSubheadingLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            launchDescriptionLabel.topAnchor.constraint(equalTo: launchSubheadingLabel.bottomAnchor, constant: 12),
            launchDescriptionLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 8),
            launchDescriptionLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -8)
        ])
    }
    
    func configureViews() {
        
        // Main View
        view.backgroundColor = UIColor(named: "Background")
        
        // Launch information
        launchNameLabel.text = launch?.name ?? "Missing"
        launchSubheadingLabel.text = "\(rocket?.name ?? "Unknown") • \(launchpad?.name ?? "Unknown")"
        launchDescriptionLabel.text = launch?.details ?? "No information."
        
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
