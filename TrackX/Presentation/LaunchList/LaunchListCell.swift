//
//  LaunchListCell.swift
//  TrackX
//
//  Created by Oliver Stenning on 25/03/2022.
//

import UIKit

class LaunchListCell: UITableViewCell {
    
    let container: UIView = {
        let view = UIView()
//        view.backgroundColor = UIColor(named: "BackgroundSecondary")
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    let typeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.secondaryLabel
        imageView.tintColor = UIColor(named: "AccentColor")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let infoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fillProportionally
        stackView.alignment = UIStackView.Alignment.leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rocketLabel: UILabel = {
       let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
       let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var launch: Launch?
    var rocket: Rocket?
    var launchpad: Launchpad?
    var payloads: [Payload]?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(container)
        container.addSubview(typeIcon)
        container.addSubview(infoStack)
        infoStack.addArrangedSubview(nameLabel)
        infoStack.addArrangedSubview(rocketLabel)
        infoStack.addArrangedSubview(dateLabel)
    }
    
    func setupConstraints() {
        container.anchor(
            to: contentView,
            padding: .init(top: 4, left: 16, bottom: 0, right: 16)
        )
        
        typeIcon.translatesAutoresizingMaskIntoConstraints = false
        typeIcon.topAnchor.constraint(equalTo: container.topAnchor, constant: 16).isActive = true
        typeIcon.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16).isActive = true
        typeIcon.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16).isActive = true
        typeIcon.centerYAnchor.constraint(equalTo: infoStack.centerYAnchor).isActive = true
        typeIcon.widthAnchor.constraint(equalToConstant: 48).isActive = true
        typeIcon.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        infoStack.anchor(
            top: container.topAnchor,
            leading: typeIcon.trailingAnchor,
            bottom: container.bottomAnchor,
            trailing: container.trailingAnchor,
            padding: .init(top: 8, left: 16, bottom: 8, right: 16)
        )
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
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            UIView.animate(
                withDuration: 0.2,
                delay: 0,
                options: .curveEaseInOut,
                animations: {
                    self.container.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                },
                completion: nil
            )
        } else {
            UIView.animate(
                withDuration: 0.2,
                delay: 0,
                options: .curveEaseInOut,
                animations: {
                    self.container.transform = CGAffineTransform.identity
                },
                completion: nil
            )
        }
    }
    
}
