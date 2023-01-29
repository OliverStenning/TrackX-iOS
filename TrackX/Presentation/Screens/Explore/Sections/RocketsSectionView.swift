//
//  RocketsCardView.swift
//  TrackX
//
//  Created by Oliver Stenning on 13/08/2022.
//

import RaptorKit
import UIKit

class RocketsSectionView: UIView {
    
    //MARK: - Views
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.rockets
        label.textColor = RKAssets.Colors.textColor.color
        label.font = RKFonts.Archivo.semiBold.font(size: 20)
        return label
    }()
    
    private let card = UIView()
    
    //MARK: - Properties

    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        configureViews()
        configureConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration Functions
    private func addViews() {
        addSubview(titleLabel)
        addSubview(card)
    }
    
    private func configureViews() {
        card.backgroundColor = RKAssets.Colors.secondaryBackgroundColor.color
        card.layer.cornerRadius = 16
        card.layer.masksToBounds = true
    }
    
    private func configureConstraints() {
        titleLabel.anchor(
            top: topAnchor,
            leading: leadingAnchor
        )
        
        card.anchor(
            top: titleLabel.bottomAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 16, left: 0, bottom: 0, right: 0)
        )
    }

}
