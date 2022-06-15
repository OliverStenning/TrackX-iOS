//
//  AccentHeadingView.swift
//  TrackX
//
//  Created by Oliver Stenning on 13/06/2022.
//

import UIKit

class AccentSubheadingView: UIView {
    
    //MARK: - Views
    private let capsule: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "AccentColor")
        view.layer.cornerRadius = 2
        return view
    }()
    
    private let subheading = SubheadingLabel()
    
    var name: String {
        didSet {
            subheading.name = name
        }
    }
    
    init(text: String = "") {
        self.name = text
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(capsule)
        addSubview(subheading)
    }
    
    private func setupConstraints() {
        capsule.anchorSize(width: 4)
        capsule.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor
        )
        
        subheading.anchor(
            top: topAnchor,
            leading: capsule.trailingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 0, left: 8, bottom: 0, right: 0)
        )
    }
    
    
}
