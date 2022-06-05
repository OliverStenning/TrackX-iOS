//
//  LaunchListCell.swift
//  TrackX
//
//  Created by Oliver Stenning on 25/03/2022.
//

import UIKit

class LaunchListCell: UITableViewCell {
    
    var typeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.secondaryLabel
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var rocketLabel: UILabel = {
       let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var dateLabel: UILabel = {
       let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var launch: Launch?
    var rocket: Rocket?
    var launchpad: Launchpad?
    var payloads: [Payload]?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(typeIcon)
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(rocketLabel)
        backgroundColor = UIColor(named: "BackgroundSecondary")
        accessoryType = .disclosureIndicator
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            typeIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            typeIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            //typeIcon.heightAnchor.constraint(equalToConstant: 40),
            typeIcon.widthAnchor.constraint(equalToConstant: 40),
            typeIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: typeIcon.trailingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            rocketLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            rocketLabel.leadingAnchor.constraint(equalTo: typeIcon.trailingAnchor, constant: 16),
            rocketLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor, multiplier: 0.8)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: rocketLabel.bottomAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            dateLabel.leadingAnchor.constraint(equalTo: typeIcon.trailingAnchor, constant: 16),
            dateLabel.heightAnchor.constraint(equalTo: rocketLabel.heightAnchor)
        ])
    }
                                    
    func set(launch: Launch, rocket: Rocket?, launchpad: Launchpad?, payloads: [Payload]?){
        
        self.launch = launch
        self.rocket = rocket
        self.launchpad = launchpad
        self.payloads = payloads
        
        nameLabel.text = launch.name
        rocketLabel.text = "\(rocket?.name ?? "Missing") • \(launchpad?.name ?? "Missing")"
        dateLabel.text = "\(formatDate(from: launch.dateUtc))"
        updateIcon()
    }
    
    func updateIcon() {
        var iconString = "satellite_symbol"
        
        if let launchName = launch?.name.lowercased() {
            if launchName.contains("crs") {
                iconString = "crate_symbol"
            } else if launchName.contains("starlink") {
                iconString = "router_symbol"
            } else if launchName.contains("crew") {
                iconString = "person_symbol"
            } else {
                if let launchDescription = launch?.details?.lowercased() {
                    if launchDescription.contains("crew") {
                        iconString = "person_symbol"
                    }
                }
                
                payloads?.forEach() { payload in
                    payload.customers?.forEach() { customer in
                        if customer.lowercased().contains("usaf") {
                            iconString = "radar_symbol"
                            return
                        }
                    }
                }
                
            }
        }
        
        let icon = UIImage(named: iconString, in: nil, with: UIImage.SymbolConfiguration(pointSize: 24, weight: .ultraLight))
        typeIcon.image = icon
    }
    
}
