//
//  LaunchCellNameView.swift
//  TrackX
//
//  Created by Oliver Stenning on 18/06/2022.
//

import UIKit

class LaunchCellNameView: UIView {
    
    //MARK: - Views
    private let nameLabel = AccentSubheadingView()
    private let statusView = StatusView()
    
    //MARK: - Properties
    private var fullLaunch: FullLaunch? = nil
    
    //MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    //MARK: - Setup Function
    func setFullLaunch(_ fullLaunch: FullLaunch?) {
        self.fullLaunch = fullLaunch
        updateViews()
    }
    
    private func setupViews() {
        addSubview(nameLabel)
        addSubview(statusView)
    }
    
    private func setupConstraints() {
        nameLabel.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: statusView.leadingAnchor,
            padding: .init(top: 20, left: 16, bottom: 0, right: 16)
        )

        statusView.anchor(
            top: nameLabel.topAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 0, left: 16, bottom: 0, right: 16)
        )
    }
 
    //MARK: - Update Functions
    func updateViews() {
        if let fullLaunch = fullLaunch {
            nameLabel.name = fullLaunch.launch.name
            
            if fullLaunch.launch.upcoming {
                statusView.setStatus(.scheduled)
            } else if fullLaunch.launch.success ?? false {
                statusView.setStatus(.success)
            } else {
                statusView.setStatus(.failed)
            }
        }
    }
    
}
