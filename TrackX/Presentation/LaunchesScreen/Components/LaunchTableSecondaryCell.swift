//
//  LaunchTableSecondaryCell.swift
//  TrackX
//
//  Created by Oliver Stenning on 25/03/2022.
//

import UIKit

class LaunchTableSecondaryCell: LaunchTableCell {
    
    //MARK: - Views
    private let nameView = LaunchCellNameView()
    private let infoView = LaunchCellInfoView()
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Functions
    func configure(with fullLaunch: FullLaunch?) {
        nameView.configure(with: fullLaunch)
        infoView.configure(with: fullLaunch)
    }
    
    private func configureViews() {
        backgroundColor = .clear
        selectionStyle = .none
        container.backgroundColor = R.color.secondaryBackgroundColor()
        
        container.addSubview(nameView)
        container.addSubview(infoView)
    }
    
    private func configureConstraints() {
        nameView.anchor(
            top: container.topAnchor,
            leading: container.leadingAnchor,
            trailing: container.trailingAnchor
        )
        
        infoView.anchor(
            top: nameView.bottomAnchor,
            leading: container.leadingAnchor,
            bottom: container.bottomAnchor,
            trailing: container.trailingAnchor
        )
    }
    
}
