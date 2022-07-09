//
//  AccentHeadingView.swift
//  TrackX
//
//  Created by Oliver Stenning on 21/06/2022.
//

import UIKit

class AccentHeadingView: UIView {
    
    //MARK: - Views
    private let capsule: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "AccentColor")
        
        return view
    }()
    
    private var heading: HeadingLabel
    
    //MARK: - Properties
    var text: String {
        didSet {
            heading.text = text
        }
    }
    
    //MARK: - Initializers
    init(text: String = "", size: HeadingSize = .h1, capsuleSize: CGFloat = 6) {
        self.text = text
        self.heading = HeadingLabel(size: size)
        self.capsule.layer.cornerRadius = (capsuleSize / 2)
        super.init(frame: .zero)
        configureViews()
        configureConstraints(capsuleSize: capsuleSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration Functions
    private func configureViews() {
        addSubview(capsule)
        addSubview(heading)
    }
    
    private func configureConstraints(capsuleSize: CGFloat) {
        capsule.anchorSize(width: capsuleSize)
        capsule.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor
        )
        
        heading.anchor(
            top: topAnchor,
            leading: capsule.trailingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 0, left: 8, bottom: 0, right: 0)
        )
    }
    
    
}
