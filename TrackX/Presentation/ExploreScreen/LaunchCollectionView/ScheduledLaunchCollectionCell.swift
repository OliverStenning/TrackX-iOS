//
//  ScheduledLaunchCollectionCell.swift
//  TrackX
//
//  Created by Oliver Stenning on 14/08/2022.
//

import UIKit

class ScheduledLaunchCollectionCell: UICollectionViewCell {
    
    //MARK: - Views
    private let nameLabel = AccentHeadingView(size: .h3, capsuleSize: 6)
    private let infoView = LaunchCellInfoView()
    
    //MARK: - Properties
    private var fullLaunch: FullLaunch? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureConstaints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration Functions
    func configure(with fullLaunch: FullLaunch?) {
        self.fullLaunch = fullLaunch
        infoView.configure(with: fullLaunch)
    }
    
    func configureViews() {
        contentView.backgroundColor = R.color.secondaryBackgroundColor()
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(infoView)
    }
    
    func configureConstaints() {
        nameLabel.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16)
        )
        
        infoView.anchor(
            top: nameLabel.bottomAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor
        )
    }
    
    //MARK: - Update Functions
    func updateViews() {
        if let fullLaunch = fullLaunch {
            nameLabel.text = fullLaunch.launch.name
        }
    }
}
