//
//  LaunchListPrimaryCell.swift
//  TrackX
//
//  Created by Oliver Stenning on 09/06/2022.
//

import UIKit

class LaunchListPrimaryCell: UITableViewCell {
    
    let container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let backgroundGradient: UIView = {
        let view = GradientView()
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    let detailsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .init(white: 1, alpha: 0.9)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .init(white: 1, alpha: 0.9)
        return label
    }()
    
    var launch: Launch?
    var rocket: Rocket?
    var launchpad: Launchpad?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstaints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(container)
        container.addSubview(backgroundImage)
        container.addSubview(backgroundGradient)
        container.addSubview(nameLabel)
        container.addSubview(detailsLabel)
        container.addSubview(dateLabel)
    }
    
    func setupConstaints() {
        container.anchor(
            to: contentView,
            padding: .init(top: 8, left: 16, bottom: 8, right: 16)
        )
        container.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        backgroundImage.anchor(to: container)
        
        backgroundGradient.anchor(to: container)
        
        nameLabel.anchor(
            leading: container.leadingAnchor,
            bottom: detailsLabel.topAnchor,
            trailing: container.trailingAnchor,
            padding: .init(top: 0, left: 16, bottom: 0, right: 16)
        )
        
        detailsLabel.anchor(
            leading: container.leadingAnchor,
            bottom: dateLabel.topAnchor,
            trailing: container.trailingAnchor,
            padding: .init(top: 0, left: 16, bottom: 0, right: 16)
        )
        
        dateLabel.anchor(
            leading: container.leadingAnchor,
            bottom: container.bottomAnchor,
            trailing: container.trailingAnchor,
            padding: .init(top: 0, left: 16, bottom: 16, right: 16)
        )
    }
    
    func set(launch: Launch, rocket: Rocket?, launchpad: Launchpad?) {
        self.launch = launch
        self.rocket = rocket
        self.launchpad = launchpad
        
        nameLabel.text = launch.name
        detailsLabel.text = "\(rocket?.name ?? "Missing") • \(launchpad?.name ?? "Missing")"
        dateLabel.text = "\(formatDate(from: launch.dateUtc))"
        
//        print(launch.links?.flickr ?? "No links")
        
        if let imageUrls = launch.links?.flickr?.original {
            if !imageUrls.isEmpty {
                backgroundImage.downloaded(from: imageUrls[0])
            } else {
                backgroundImage.image = UIImage(named: "placeholder_image")
//                backgroundImage.downloaded(from: "https://live.staticflickr.com/65535/51676939646_1a12780e54_o.jpg")
            }

        }
        
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
