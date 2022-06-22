//
//  LaunchpadSectionStackView.swift
//  TrackX
//
//  Created by Oliver Stenning on 13/06/2022.
//

import UIKit

class LaunchpadSectionStaclView: UIStackView {
    
    //MARK: - Views
    private let sectionLabel = SubheadingLabel(text: "Launchpad")
    private let nameView = NameValueView(name: "Name")
    private let fullNameView = NameValueView(name: "Full Name")
    private let regionView = NameValueView(name: "Region")
    
    //MARK: - Properties
    var launchpad: Launchpad? = nil {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Functions
    private func setupViews() {
        axis = .vertical
        distribution = .fill
        spacing = 16
        
        addArrangedSubview(sectionLabel)
        addArrangedSubview(nameView)
        addArrangedSubview(fullNameView)
        addArrangedSubview(regionView)
    }
    
    private func setupConstraints() {

    }
    
    //MARK: - Update Functions
    private func updateViews() {
        nameView.value = launchpad?.name ?? "Unknown"
        fullNameView.value = launchpad?.fullName ?? "Unknown"
        regionView.value = launchpad?.region ?? "Unknown"
    }
    
}
