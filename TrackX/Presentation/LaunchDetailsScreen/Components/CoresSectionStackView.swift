//
//  CoresSectionStackView.swift
//  TrackX
//
//  Created by Oliver Stenning on 19/06/2022.
//

import UIKit

class CoresSectionStackView: UIStackView {
    
    //MARK: - Views
    private let sectionLabel = HeadingLabel(text: "Booster Cores", size: .h3)
    
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
    }
    
    private func configureConstraints() {

    }
    
    //MARK: - Update Functions
    private func updateViews() {

    }
    
}
