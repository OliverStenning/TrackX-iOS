//
//  SectionHeaderView.swift
//  TrackX
//
//  Created by Oliver Stenning on 10/06/2022.
//

import UIKit

class LaunchListSectionHeader: UIView {
    
    fileprivate let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    var name = "" {
        didSet {
            nameLabel.text = name
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    fileprivate func setupViews() {
        backgroundColor = UIColor(named: "Background")
        addSubview(nameLabel)
    }
    
    fileprivate func setupConstraints() {
        nameLabel.anchor(to: self, padding: .init(top: 8, left: 24, bottom: 0, right: 24))
    }
    
}
