//
//  CoresSectionStackView.swift
//  TrackX
//
//  Created by Oliver Stenning on 19/06/2022.
//

import UIKit

class CoresSectionStackView: UIStackView {
    
    //MARK: - Views
    private let sectionLabel = HeadingLabel(text: "Booster Cores", size: .h2)
    private var coreStacks: [UIStackView] = []
    
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
    func configureWith(cores: [Core?]?, launchCores: [LaunchCore?]?, landpads: [Landpad?]?) {
        if let cores = cores {
            if let launchCores = launchCores {
                if let landpads = landpads {
                    for x in 0 ..< cores.count {
                        let coreCell = CoreCellView()
                        coreCell.configureWith(core: cores[x], launchCore: launchCores[x], landpad: landpads[x])
                        coreStacks.append(coreCell)
                        addArrangedSubview(coreCell)
                    }
                }
            }
        }
    }
    
    private func configureViews() {
        axis = .vertical
        distribution = .fill
        spacing = 32
        
        addArrangedSubview(sectionLabel)
    }
    
    private func configureConstraints() {

    }
    
    //MARK: - Update Functions
    private func updateViews() {

    }
    
}
