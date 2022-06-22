//
//  LaunchCellInfoView.swift
//  TrackX
//
//  Created by Oliver Stenning on 18/06/2022.
//

import UIKit

class LaunchCellInfoView: UIView {
    
    //MARK: - Views
    private let containerStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let leftStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.spacing = 4
        return stackView
    }()
    
    private let rightStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .trailing
        stackView.spacing = 4
        return stackView
    }()

    private let rocketLabel = BodyLabel(bold: true)
    private let dateLabel = BodyLabel(bold: true)
    private let timeLabel = BodyLabel(bold: true)
    
    private let coreLabel = BodyLabel(bold: true)
    private let launchpadLabel = BodyLabel(bold: true)
    private let landpadLabel = BodyLabel(bold: true)
    
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
    
    //MARK: - Setup Functions
    func setFullLaunch(_ fullLaunch: FullLaunch?) {
        self.fullLaunch = fullLaunch
        updateViews()
    }
    
    private func setupViews() {
        addSubview(containerStack)
        containerStack.addArrangedSubview(leftStack)
        containerStack.addArrangedSubview(rightStack)
        
        leftStack.addArrangedSubview(rocketLabel)
        leftStack.addArrangedSubview(dateLabel)
        leftStack.addArrangedSubview(timeLabel)
        
        rightStack.addArrangedSubview(coreLabel)
        rightStack.addArrangedSubview(launchpadLabel)
        rightStack.addArrangedSubview(landpadLabel)
    }
    
    private func setupConstraints() {
        containerStack.anchor(
            to: self,
            padding: .init(top: 12, left: 16, bottom: 16, right: 16)
        )
    }
 
    //MARK: - Update Functions
    func updateViews() {
        if let fullLaunch = fullLaunch {
            rocketLabel.text = fullLaunch.rocket?.name ?? "Unknown"
            dateLabel.text = "\(formatDate(from: fullLaunch.launch.dateUtc, as: .shortDate))"
            timeLabel.text = "\(formatDate(from: fullLaunch.launch.dateUtc, as: .time))"
            
            if fullLaunch.cores?.isEmpty == false {
                coreLabel.text = fullLaunch.cores?[0].serial ?? "Unknown"
            } else {
                coreLabel.text = "Unknown"
            }
            
            launchpadLabel.text = fullLaunch.launchpad?.name ?? "Unknown"
            
            if fullLaunch.coreLandpads?.isEmpty == false {
                landpadLabel.text = fullLaunch.coreLandpads?[0].name ?? "Unknown"
            } else {
                landpadLabel.text = "Unknown"
            }
        }
    }
    
}
