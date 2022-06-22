//
//  PayloadsSectionStackView.swift
//  TrackX
//
//  Created by Oliver Stenning on 19/06/2022.
//

import UIKit

class PayloadsSectionStackView: UIStackView {
    
    //MARK: - Views
    private let sectionLabel = SubheadingLabel(text: "Payloads")
    
    //MARK: - Properties
    
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
    }
    
    private func setupConstraints() {

    }
    
    //MARK: - Update Functions
    private func updateViews() {

    }
    
}
