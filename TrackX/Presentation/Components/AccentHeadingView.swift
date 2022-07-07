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
    
    //MARK: - Properties
    var text: String {
        didSet {
            heading.text = text
        }
    }
    
    //MARK: - Initializers
    init(text: String = "") {
        self.text = text
        super.init(frame: .zero)
        configureViews()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration Functions
    private func configureViews() {
        addSubview(capsule)
        addSubview(heading)
    }
    
    private func configureConstraints() {
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
