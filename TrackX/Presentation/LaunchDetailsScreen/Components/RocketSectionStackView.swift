//
//  RocketSectionStackView.swift
//  TrackX
//
//  Created by Oliver Stenning on 13/06/2022.
//

import UIKit

class RocketSectionStackView: UIStackView {
    
    //MARK: - Views
    private let sectionLabel = HeadingLabel(text: "Launch Vehicle", size: .h2)
    private let nameLabel = NameValueView(name: "Name")
    private let descriptionLabel = NameValueView(name: "Description")

    private let detailsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    private let successRateView = NameValueView(name: "Success")
    private let stagesView = NameValueView(name: "Stages")
    private let costView = NameValueView(name: "Cost")
    
    private let measuresStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    private let massView = NameValueView(name: "Mass")
    private let heightView = NameValueView(name: "Height")
    private let diameterView = NameValueView(name: "Diameter")
    
    //MARK: - Properties
    var rocket: Rocket? = nil {
        didSet {
            updateViews()
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
        
        addArrangedSubview(sectionLabel)
        addArrangedSubview(nameLabel)
        addArrangedSubview(descriptionLabel)
        addArrangedSubview(detailsStack)
        addArrangedSubview(measuresStack)
        
        detailsStack.addArrangedSubview(successRateView)
        detailsStack.addArrangedSubview(stagesView)
        detailsStack.addArrangedSubview(costView)
        
        measuresStack.addArrangedSubview(massView)
        measuresStack.addArrangedSubview(heightView)
        measuresStack.addArrangedSubview(diameterView)
    }
    
    private func configureConstraints() {
        detailsStack.anchorWidth(to: self)
        measuresStack.anchorWidth(to: self)
    }
    
    //MARK: - Update Functions
    private func updateViews() {
        nameLabel.value = rocket?.name ?? "Unknown"
        descriptionLabel.value = rocket?.description ?? "Unknown"
        
        if let stages = rocket?.stages {
            stagesView.value = "\(stages)"
        } else {
            stagesView.value = "Unknown"
        }
        
        if let successRate = rocket?.successRatePct {
            successRateView.value = "\(successRate)%"
        } else {
            successRateView.value = "Unknown"
        }
        
        if let cost = rocket?.costPerLaunch {
            costView.value = "$\(cost / 1000000)m"
        } else {
            costView.value = "Unknown"
        }
        
        massView.value = "\((rocket?.mass?.kg ?? 0) / 1000)t"
        massView.alternate = "\((rocket?.mass?.lb ?? 0) / 1000)k lbs"

        heightView.value = "\(rocket?.height?.meters ?? 0)m"
        heightView.alternate = "\(rocket?.height?.feet ?? 0)ft"

        diameterView.value = "\(rocket?.diameter?.meters ?? 0)m"
        diameterView.alternate = "\(rocket?.diameter?.feet ?? 0)ft"
    }
    
}
