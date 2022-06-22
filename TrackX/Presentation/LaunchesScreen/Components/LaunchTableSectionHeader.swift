//
//  SectionHeaderView.swift
//  TrackX
//
//  Created by Oliver Stenning on 10/06/2022.
//

import UIKit

class LaunchTableSectionHeader: UIView {
    
    fileprivate let nameLabel = HeadingLabel()
    
    var text = "" {
        didSet {
            nameLabel.text = text
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        nameLabel.text = text
        
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
