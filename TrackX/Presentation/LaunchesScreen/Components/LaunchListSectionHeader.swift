//
//  SectionHeaderView.swift
//  TrackX
//
//  Created by Oliver Stenning on 10/06/2022.
//

import UIKit

class LaunchListSectionHeader: UIView {
    
    fileprivate let nameLabel = HeadingLabel()
    
    var name = "" {
        didSet {
            nameLabel.name = name
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(name: String) {
        super.init(frame: .zero)
        self.name = name
        nameLabel.text = name
        
        setupViews()
        setupConstraints()
        
    }
    
    fileprivate func setupViews() {
        backgroundColor = UIColor(named: "BackgroundColor")
        addSubview(nameLabel)
    }
    
    fileprivate func setupConstraints() {
        nameLabel.anchor(to: self, padding: .init(top: 16, left: 24, bottom: 8, right: 24))
    }
    
}
