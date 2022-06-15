//
//  LaunchListSecondaryCell.swift
//  TrackX
//
//  Created by Oliver Stenning on 25/03/2022.
//

import UIKit

class LaunchListSecondaryCell: UITableViewCell {
    
    let container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = UIColor(named: "SecondaryBackgroundColor")
        view.clipsToBounds = true
        return view
    }()
    
    private let nameLabel = AccentSubheadingView()
    
    private let statusView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 6
        return view
    }()
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "RubikRoman-Medium", size: 14)
        label.textColor = UIColor(named: "BackgroundColor")
        return label
    }()
    
    let leftStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.spacing = 4
        return stackView
    }()
    
    let rightStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .trailing
        stackView.spacing = 4
        return stackView
    }()

    private let rocketLabel = BodyLabel(bold: true)
    private let dateLabel = BodyLabel(bold: true)
    private let timeLabel = BodyLabel(bold: true)
    
    private let coreLabel = BodyLabel(bold: true)
    private let launchpadLabel = BodyLabel(bold: true)
    private let landpadLabel = BodyLabel(bold: true)
    
    var fullLaunch: FullLaunch? = nil
    
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
        
        container.addSubview(nameLabel)
        container.addSubview(statusView)
        container.addSubview(leftStack)
        container.addSubview(rightStack)
        
        leftStack.addArrangedSubview(rocketLabel)
        leftStack.addArrangedSubview(dateLabel)
        leftStack.addArrangedSubview(timeLabel)
        
        rightStack.addArrangedSubview(coreLabel)
        rightStack.addArrangedSubview(launchpadLabel)
        rightStack.addArrangedSubview(landpadLabel)
        
        statusView.addSubview(statusLabel)
    }
    
    func setupConstraints() {
        container.anchor(
            to: contentView,
            padding: .init(top: 8, left: 16, bottom: 8, right: 16)
        )
        
        nameLabel.anchor(
            top: container.topAnchor,
            leading: container.leadingAnchor,
            trailing: statusView.leadingAnchor,
            padding: .init(top: 20, left: 16, bottom: 0, right: 16)
        )
        
        leftStack.anchor(
            top: nameLabel.bottomAnchor,
            leading: container.leadingAnchor,
            bottom: container.bottomAnchor,
            padding: .init(top: 16, left: 16, bottom: 16, right: 0)
        )
        
        rightStack.anchor(
            top: nameLabel.bottomAnchor,
            bottom: container.bottomAnchor,
            trailing: container.trailingAnchor,
            padding: .init(top: 16, left: 0, bottom: 16, right: 16)
        )
        
        statusView.anchorSize(height: 24, width: 80)
        statusView.anchorYCenter(to: nameLabel)
        statusView.anchor(
            trailing: container.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 16)
        )
        
        statusLabel.anchorXCenter(to: statusView)
        statusLabel.anchorYCenter(to: statusView)
        
    }
         
    func setFullLaunch(_ fullLaunch: FullLaunch?) {
        self.fullLaunch = fullLaunch
        updateViews()
    }
    
    func updateViews() {
        if let fullLaunch = fullLaunch {
            nameLabel.name = fullLaunch.launch.name
            rocketLabel.name = fullLaunch.rocket?.name ?? "Unknown"
            dateLabel.name = "\(formatDate(from: fullLaunch.launch.dateUtc, as: .shortDate))"
            timeLabel.name = "\(formatDate(from: fullLaunch.launch.dateUtc, as: .time))"
            
            if fullLaunch.cores?.isEmpty == false {
                coreLabel.name = fullLaunch.cores?[0].serial ?? "Unknown"
            } else {
                coreLabel.name = "Unknown"
            }
            
            launchpadLabel.name = fullLaunch.launchpad?.name ?? "Unknown"
            
            if fullLaunch.coreLandpads?.isEmpty == false {
                landpadLabel.name = fullLaunch.coreLandpads?[0].name ?? "Unknown"
            } else {
                landpadLabel.name = "Unknown"
            }
    
            if fullLaunch.launch.upcoming {
                statusView.backgroundColor = UIColor(named: "AccentColor")
                statusLabel.text = "Scheduled"
                statusLabel.textColor = UIColor(named: "BackgroundColor")
            } else if fullLaunch.launch.success ?? false {
                statusView.backgroundColor = .systemGreen
                statusLabel.text = "Success"
                statusLabel.textColor = UIColor(named: "BackgroundColor")
            } else {
                statusView.backgroundColor = .systemRed
                statusLabel.text = "Failed"
                statusLabel.textColor = UIColor(named: "BackgroundColor")
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
