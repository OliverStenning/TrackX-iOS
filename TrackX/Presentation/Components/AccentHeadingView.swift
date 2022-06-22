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
        view.layer.cornerRadius = 3
        return view
    }()
    
    private let heading = HeadingLabel()
    
    var text: String {
        didSet {
            heading.text = text
        }
    }
    
    init(text: String = "") {
        self.text = text
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(capsule)
        addSubview(heading)
    }
    
    private func setupConstraints() {
        capsule.anchorSize(width: 6)
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
