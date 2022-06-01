//
//  LaunchListCell.swift
//  TrackX
//
//  Created by Oliver Stenning on 25/03/2022.
//

import UIKit

class LaunchListCell: UITableViewCell {
    
    var typeIcon: UIImageView = {
        let imgView = UIImageView(image: UIImage(systemName: "globe.europe.africa"))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.tintColor = .black
        return imgView
    }()
    
    var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .label
        lbl.font = .systemFont(ofSize: 17, weight: .medium)
        return lbl
    }()
    
    var rocketLabel: UILabel = {
       let lbl = UILabel()
        lbl.textColor = .secondaryLabel
        lbl.font = .systemFont(ofSize: 15)
        return lbl
    }()
    
    var dateLabel: UILabel = {
       let lbl = UILabel()
        lbl.textColor = .tertiaryLabel
        lbl.font = .systemFont(ofSize: 18)
        return lbl
    }()

    var launchpadLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .lightGray
        lbl.font = .systemFont(ofSize: 16)
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(typeIcon)
        contentView.addSubview(nameLabel)
        //contentView.addSubview(dateLabel)
        contentView.addSubview(rocketLabel)
        contentView.addSubview(launchpadLabel)
        
        typeIcon.translatesAutoresizingMaskIntoConstraints = false
        typeIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        typeIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        typeIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        typeIcon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        typeIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: typeIcon.trailingAnchor, constant: 16).isActive = true
        
        rocketLabel.translatesAutoresizingMaskIntoConstraints = false
        rocketLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
        rocketLabel.leadingAnchor.constraint(equalTo: typeIcon.trailingAnchor, constant: 16).isActive = true
        
        //dateLabel.translatesAutoresizingMaskIntoConstraints = false
        //dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        //dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24).isActive = true
        
        launchpadLabel.translatesAutoresizingMaskIntoConstraints = false
        launchpadLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
        launchpadLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(launch: Launch, rocket: Rocket?){
        nameLabel.text = launch.name
        nameLabel.textColor = .black
        
        rocketLabel.text = "\(rocket?.name ?? "Missing") • Cape Canaveral"
        dateLabel.text = "April 9"
        //launchpadLabel.text = "Cape Canaveral"
    }
    
}
