//
//  ScheduledLaunchCollectionCell.swift
//  TrackX
//
//  Created by Oliver Stenning on 14/08/2022.
//

import UIKit

class ScheduledLaunchCollectionCell: UICollectionViewCell {
    
    //MARK: - Views
    private let cardView = UIView()
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
        addViews()
        configureViews()
        configureConstaints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration Functions
    func addViews() {
        contentView.addSubview(cardView)
        cardView.addSubview(nameLabel)
        cardView.addSubview(infoView)
    }
    
    func configure(with fullLaunch: FullLaunch?) {
        self.fullLaunch = fullLaunch
        infoView.configure(with: fullLaunch)
    }
    
    private func configureViews() {
        isUserInteractionEnabled = true
        cardView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(pressLaunch))
        gesture.numberOfTapsRequired = 1
        gesture.cancelsTouchesInView = false
        cardView.addGestureRecognizer(gesture)
        
//        cardView.backgroundColor = R.color.secondaryBackgroundColor()
        cardView.layer.cornerRadius = 16
        cardView.layer.masksToBounds = true
    }
    
    private func configureConstaints() {
        cardView.anchor(to: contentView)
        
        nameLabel.anchor(
            top: cardView.topAnchor,
            leading: cardView.leadingAnchor,
            trailing: cardView.trailingAnchor,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16)
        )
        
        infoView.anchor(
            top: nameLabel.bottomAnchor,
            leading: cardView.leadingAnchor,
            bottom: cardView.bottomAnchor,
            trailing: cardView.trailingAnchor
        )
    }
    
    //MARK: - Update Functions
    private func updateViews() {
        if let fullLaunch = fullLaunch {
            nameLabel.text = fullLaunch.launch.name
        }
    }
    
    //MARK: - Interaction Functions
    @objc private func pressLaunch() {
        cardView.springAnimate()
    }
}
