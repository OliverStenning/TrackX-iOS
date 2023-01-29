//
//  AboutSectionView.swift
//  TrackX
//
//  Created by Oliver Stenning on 15/08/2022.
//

import RaptorKit
import UIKit
import SFSafeSymbols

class AboutSectionView: UIView {
    
    //MARK: - Views
    private let cardView = UIView()
    
    private let aboutLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.about
        label.textColor = RKAssets.Colors.textColor.color
        label.font = RKFonts.Archivo.medium.font(size: 20)
        return label
    }()
    
    private let aboutIcon: UIImageView = {
        let image = UIImage(systemSymbol: .infoCircleFill)
        let imageView = UIImageView(image: image)
        imageView.tintColor = RKAssets.Colors.textColor.color
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
        cardView.addSubview(aboutLabel)
        cardView.addSubview(aboutIcon)
    }
    
    private func configureViews() {
        cardView.backgroundColor = RKAssets.Colors.secondaryBackgroundColor.color
        cardView.layer.cornerRadius = 16
        cardView.layer.masksToBounds = true
        
        isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(pressAbout))
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
        
        aboutLabel.anchor(
            top: cardView.topAnchor,
            leading: cardView.leadingAnchor,
            bottom: cardView.bottomAnchor,
            padding: .init(top: padding, left: padding * 1.5, bottom: padding, right: 0)
        )
        
        aboutIcon.anchor(
            top: cardView.topAnchor,
            bottom: cardView.bottomAnchor,
            trailing: cardView.trailingAnchor,
            padding: .init(top: padding, left: padding, bottom: padding, right: padding * 1.5)
        )
    
    }
    
    //MARK: - Interaction Functions
    @objc private func pressAbout() {
        springAnimate()
    }
}
