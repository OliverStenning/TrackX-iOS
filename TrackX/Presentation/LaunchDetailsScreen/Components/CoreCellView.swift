//
//  CoreCellView.swift
//  TrackX
//
//  Created by Oliver Stenning on 23/06/2022.
//

import UIKit

class CoreCellView: UIStackView {
    
    //MARK: - Views
    private let nameStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    private let serialView = NameValueView(name: "Serial")
    private let blockView = NameValueView(name: "Block")
    
    private let lastUpdateView = NameValueView(name: "Last Update")
    
    private let infoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    private let statusView = NameValueView(name: "Status")
    private let reusesView = NameValueView(name: "Reuses")
    
    private let landingsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    private let launchSiteView = NameValueView(name: "Launchsite")
    private let droneshipView = NameValueView(name: "Droneship")

    //MARK: - Properies
    var core: Core? = nil {
        didSet {
            
        }
    }
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration Functions
    private func configureViews() {
        axis = .vertical
        distribution = .fill
        spacing = 16
        
        addArrangedSubview(nameStack)
        addArrangedSubview(lastUpdateView)
        addArrangedSubview(infoStack)
        addArrangedSubview(landingsStack)
        
        nameStack.addArrangedSubview(serialView)
        nameStack.addArrangedSubview(blockView)
        
        infoStack.addArrangedSubview(statusView)
        infoStack.addArrangedSubview(reusesView)
        
        landingsStack.addArrangedSubview(launchSiteView)
        landingsStack.addArrangedSubview(droneshipView)
    }
    
    private func configureConstraints() {
        
    }
}
