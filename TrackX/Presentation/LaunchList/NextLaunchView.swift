//
//  NextLaunchView.swift
//  TrackX
//
//  Created by Oliver Stenning on 23/05/2022.
//

import UIKit

final class NextLaunchView: UIView {
    
    var launch: Launch?
    var rocket: Rocket?
    var launchpad: Launchpad?
    
    let mainImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "placeholder_image"))
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let infoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        nameLabel.textColor = .label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    let rocketLabel: UILabel = {
        let rocketLabel = UILabel()
        rocketLabel.font = .systemFont(ofSize: 14)
        rocketLabel.textColor = .secondaryLabel
        rocketLabel.translatesAutoresizingMaskIntoConstraints = false
        return rocketLabel
    }()
    
    let launchpadLabel: UILabel = {
        let launchpadLabel = UILabel()
        launchpadLabel.font = .systemFont(ofSize: 14)
        launchpadLabel.textColor = .secondaryLabel
        launchpadLabel.translatesAutoresizingMaskIntoConstraints = false
        return launchpadLabel
    }()
    
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = .systemFont(ofSize: 14, weight: .medium)
        dateLabel.textColor = .secondaryLabel
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        //backgroundColor = UIColor(named: "BackgroundSecondary")

        addSubview(mainImage)
        addSubview(infoStack)
        
        infoStack.addArrangedSubview(nameLabel)
        infoStack.addArrangedSubview(rocketLabel)
        infoStack.addArrangedSubview(launchpadLabel)
        infoStack.addArrangedSubview(dateLabel)
        
        layer.cornerRadius = 12
        clipsToBounds = true
        
        setupLayout()
    }
    
    func setupLayout() {
        
        NSLayoutConstraint.activate([
            mainImage.topAnchor.constraint(equalTo: topAnchor),
            mainImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainImage.widthAnchor.constraint(equalToConstant: 75),
            mainImage.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            infoStack.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            infoStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            infoStack.leadingAnchor.constraint(equalTo: mainImage.trailingAnchor, constant: 12),
            infoStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
        
    }
    
    func set(launch: Launch, rocket: Rocket?, launchpad: Launchpad?) {
        self.launch = launch
        self.rocket = rocket
        self.launchpad = launchpad
        
        nameLabel.text = launch.name
        rocketLabel.text = "\(rocket?.name ?? "Missing")"
        launchpadLabel.text =  "\(launchpad?.name ?? "Missing")"
        dateLabel.text = "\(formatDate(from: launch.dateUtc))"
        
    }
    
}
