//
//  SettingsSectionView.swift
//  TrackX
//
//  Created by Oliver Stenning on 15/08/2022.
//

import RaptorKit
import UIKit
import SFSafeSymbols

class SettingsSectionView: UIView {
    
    //MARK: - Views
    private let cardView = UIView()
    
    private let settingsLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.settings
        label.textColor = RKAssets.Colors.textPrimary.color
        label.font = RKFonts.Archivo.medium.font(size: 20)
        return label
    }()
    
    private let settingsIcon: UIImageView = {
        let image = UIImage(systemSymbol: .gearshapeFill)
        let imageView = UIImageView(image: image)
        imageView.tintColor = RKAssets.Colors.textPrimary.color
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //MARK: - Initializers
    init() {
        super.init(frame: .zero)
        addViews()
        configureViews()
        configureConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration Functions
    private func addViews() {
        addSubview(cardView)
        addSubview(settingsLabel)
        addSubview(settingsIcon)
    }
    
    private func configureViews() {
        cardView.backgroundColor = RKAssets.Colors.backgroundSecondary.color
        cardView.layer.cornerRadius = 16
        cardView.layer.masksToBounds = true
        
        isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(pressSettings))
        gesture.numberOfTapsRequired = 1
        addGestureRecognizer(gesture)
    }
    
    private func configureConstraints() {
        let margin: CGFloat = 16
        let padding: CGFloat = 16

        cardView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 0, left: margin, bottom: 0, right: margin)
        )
        
        settingsLabel.anchor(
            top: cardView.topAnchor,
            leading: cardView.leadingAnchor,
            bottom: cardView.bottomAnchor,
            padding: .init(top: padding, left: padding * 1.5, bottom: padding, right: 0)
        )

        settingsIcon.anchor(
            top: cardView.topAnchor,
            bottom: cardView.bottomAnchor,
            trailing: cardView.trailingAnchor,
            padding: .init(top: padding, left: padding, bottom: padding, right: padding * 1.5)
        )
    }

    //MARK: - Interaction Functions
    @objc private func pressSettings() {
        //TODO: add settings view
        springAnimate()
    }
}
