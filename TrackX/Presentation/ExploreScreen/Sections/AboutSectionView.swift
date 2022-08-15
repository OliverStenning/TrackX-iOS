//
//  AboutSectionView.swift
//  TrackX
//
//  Created by Oliver Stenning on 15/08/2022.
//

import UIKit

class AboutSectionView: UIView {
    
    //MARK: - Views
    private let card = UIView()
    
    private let aboutLabel: UILabel = {
        let label = UILabel()
        label.text = "About"
        label.font = R.font.archivoMedium(size: 20)
        label.textColor = R.color.textColor()
        return label
    }()
    
    private let aboutIcon: UIImageView = {
        let image = UIImage(systemSymbol: .infoCircleFill)
        
        let imageView = UIImageView(image: image)
        imageView.tintColor = R.color.textColor()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //MARK: - Properties

    var highlighted: Bool = false {
        didSet {
            animateHighlighted()
        }
    }
    var animating: Bool = false
    
    //MARK: - Initializers
    init() {
        super.init(frame: .zero)
        configureViews()
        configureConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration Functions
    private func configureViews() {
        self.isUserInteractionEnabled = true
        
        card.backgroundColor = R.color.secondaryBackgroundColor()
        card.layer.cornerRadius = 16
        card.layer.masksToBounds = true
        
        addSubview(card)
        addSubview(aboutLabel)
        addSubview(aboutIcon)
    }
    
    private func configureConstraints() {
        let margin: CGFloat = 16
        let padding: CGFloat = 16
        
        card.anchor(
            top: self.topAnchor,
            leading: self.leadingAnchor,
            bottom: self.bottomAnchor,
            trailing: self.trailingAnchor,
            padding: .init(top: 0, left: margin, bottom: 0, right: margin)
        )
        
        aboutLabel.anchor(
            top: card.topAnchor,
            leading: card.leadingAnchor,
            bottom: card.bottomAnchor,
            padding: .init(top: padding, left: padding * 1.5, bottom: padding, right: 0)
        )
        
        aboutIcon.anchor(
            top: card.topAnchor,
            bottom: card.bottomAnchor,
            trailing: card.trailingAnchor,
            padding: .init(top: padding, left: padding, bottom: padding, right: padding * 1.5)
        )
    
    }
    
    //MARK: - Update Functions
    private func updateInformation() {
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        highlighted = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        highlighted = false
        //TODO: show next launch view
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        highlighted = false
    }
    
    func animateHighlighted() {
        if highlighted {
            animating = true
            pressViewAnimation { _ in
                if !self.highlighted {
                    self.releaseViewAnimation()
                }
                self.animating = false
            }
        } else {
            if !animating {
                releaseViewAnimation()
            }
        }
    }
    
    private func pressViewAnimation(completion: ((Bool) -> Void)?) {
        UIView.animate(
            withDuration: 0.05,
            delay: 0,
            options: .curveEaseInOut,
            animations: { self.transform = CGAffineTransform(scaleX: 0.975, y: 0.975) },
            completion: completion
        )
    }
    
    private func releaseViewAnimation() {
        UIView.animate(
            withDuration: 0.05,
            delay: 0,
            options: .curveEaseInOut,
            animations: { self.transform = CGAffineTransform.identity },
            completion: nil
        )
    }
}
