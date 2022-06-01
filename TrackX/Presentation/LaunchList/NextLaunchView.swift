//
//  NextLaunchView.swift
//  TrackX
//
//  Created by Oliver Stenning on 23/05/2022.
//

import UIKit

final class NextLaunchView: UIView {
    
    var nextLaunch: Launch? = nil
    
    var launchView = UIView()
    
    let mainImage: UIImageView = {
        let image = UIImageView()
        if let url = URL(string: "https://live.staticflickr.com/65535/49635401403_96f9c322dc_o.jpg") {
            image.load(url: url)
        }
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        nameLabel.text = "Starlink"
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    let rocketLabel: UILabel = {
        let rocketLabel = UILabel()
        rocketLabel.font = .systemFont(ofSize: 16)
        rocketLabel.textColor = .gray
        rocketLabel.text = "Falcon 9 Block 5"
        rocketLabel.translatesAutoresizingMaskIntoConstraints = false
        return rocketLabel
    }()
    
    let launchpadLabel: UILabel = {
        let launchpadLabel = UILabel()
        launchpadLabel.font = .systemFont(ofSize: 16)
        launchpadLabel.textColor = .gray
        launchpadLabel.text = "LC-39A, Cape Canaveral, US"
        launchpadLabel.translatesAutoresizingMaskIntoConstraints = false
        return launchpadLabel
    }()
    
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = .systemFont(ofSize: 16, weight: .medium)
        dateLabel.textColor = .black
        dateLabel.text = "25th May, 2022"
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
        backgroundColor = .white
        
        addSubview(launchView)
        
        launchView.addSubview(mainImage)
        launchView.addSubview(nameLabel)
        launchView.addSubview(rocketLabel)
        launchView.addSubview(launchpadLabel)
        launchView.addSubview(dateLabel)
        
        launchView.layer.cornerRadius = 12
        launchView.clipsToBounds = true
        
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.05
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 5
        
        setupLayout()
    }
    
    func setupLayout() {
        
        launchView.translatesAutoresizingMaskIntoConstraints = false
        launchView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        launchView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        launchView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        launchView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        mainImage.topAnchor.constraint(equalTo: launchView.topAnchor).isActive = true
        mainImage.bottomAnchor.constraint(equalTo: launchView.bottomAnchor).isActive = true
        mainImage.leadingAnchor.constraint(equalTo: launchView.leadingAnchor).isActive = true
        mainImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: launchView.topAnchor, constant: 12).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: mainImage.trailingAnchor, constant: 12).isActive = true
        
        rocketLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        rocketLabel.leadingAnchor.constraint(equalTo: mainImage.trailingAnchor, constant: 12).isActive = true
        
        launchpadLabel.topAnchor.constraint(equalTo: rocketLabel.bottomAnchor, constant: 4).isActive = true
        launchpadLabel.leadingAnchor.constraint(equalTo: mainImage.trailingAnchor, constant: 12).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: launchpadLabel.bottomAnchor, constant: 12).isActive = true
        //dateLabel.bottomAnchor.constraint(equalTo: launchView.bottomAnchor, constant: 12).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: mainImage.trailingAnchor, constant: 12).isActive = true
        
    }
    
}
