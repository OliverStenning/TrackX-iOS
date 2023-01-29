//
//  LaunchTableSecondaryCell.swift
//  TrackX
//
//  Created by Oliver Stenning on 25/03/2022.
//

import RaptorKit
import UIKit

class ScheduledLaunchTableCell: LaunchTableCell {
    
    //MARK: - Views
    private let nameLabel = AccentHeadingView(size: .h3, capsuleSize: 6)
    private let infoView = LaunchCellInfoView()
    
    //MARK: - Properties
    private var fullLaunch: FullLaunch? = nil
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        configureViews()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Functions
    func addViews() {
        container.addSubview(nameLabel)
        container.addSubview(infoView)
    }
    
    func configure(with fullLaunch: FullLaunch?) {
        self.fullLaunch = fullLaunch
        infoView.configure(with: fullLaunch)
        updateViews()
    }
    
    private func configureViews() {
        backgroundColor = .clear
        selectionStyle = .none
        container.backgroundColor = RKAssets.Colors.secondaryBackgroundColor.color
    }
    
    private func configureConstraints() {
        nameLabel.anchor(
            top: container.topAnchor,
            leading: container.leadingAnchor,
            trailing: container.trailingAnchor,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16)
        )
        
        infoView.anchor(
            top: nameLabel.bottomAnchor,
            leading: container.leadingAnchor,
            bottom: container.bottomAnchor,
            trailing: container.trailingAnchor
        )
    }
    
    //MARK: - Update Functions
    private func updateViews() {
        if let fullLaunch = fullLaunch {
            nameLabel.text = fullLaunch.launch.name
        }
    }
    
}
