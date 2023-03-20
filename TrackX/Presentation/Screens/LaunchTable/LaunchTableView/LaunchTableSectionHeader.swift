//
//  SectionHeaderView.swift
//  TrackX
//
//  Created by Oliver Stenning on 10/06/2022.
//

import RaptorKit
import UIKit

class LaunchTableSectionHeader: UIView {
    
    //MARK: - Views
    private let nameLabel = HeadingLabel(size: .h1)
    
    //MARK: - Properties
    var text = "" {
        didSet {
            nameLabel.text = text
        }
    }
    
    //MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        nameLabel.text = text
        
        configureViews()
        configureConstraints()
        
    }
    
    //MARK: - Configuration Functions
    private func configureViews() {
        backgroundColor = RKAssets.Colors.background1.color
        addSubview(nameLabel)
    }
    
    private func configureConstraints() {
        nameLabel.anchor(to: self, padding: .init(top: 0, left: 24, bottom: 0, right: 24))
    }
    
}
