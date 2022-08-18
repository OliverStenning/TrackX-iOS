//
//  CoreCellView.swift
//  TrackX
//
//  Created by Oliver Stenning on 23/06/2022.
//

import UIKit

class CoreCellView: UIStackView {
    
    //MARK: - Views
    private let serialLabel = AccentHeadingView(size: .h4, capsuleSize: 4)

    private let landingStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    private let landingTypeView = NameValueView(name: "Landing")
    private let landpadView = NameValueView(name: "Landpad")
    
    private let lastUpdateLabel = NameValueView(name: "Last Update")
    
    private let historyStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    private let statusView = NameValueView(name: "Status")
    private let reusesView = NameValueView(name: "Reuses")
    private let blockView = NameValueView(name: "Block")

    //MARK: - Properies
    var core: Core? = nil {
        didSet {
            updateCoreViews()
        }
    }
    var launchCore: LaunchCore? = nil {
        didSet {
            updateLaunchCoreViews()
        }
    }
    var landpad: Landpad? = nil {
        didSet {
            updateLandpadViews()
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
    func configureWith(core: Core?, launchCore: LaunchCore?, landpad: Landpad?) {
        self.core = core
        self.launchCore = launchCore
        self.landpad = landpad
    }
    
    private func configureViews() {
        axis = .vertical
        distribution = .fill
        spacing = 16
        
        addArrangedSubview(serialLabel)
        addArrangedSubview(landingStack)
        addArrangedSubview(lastUpdateLabel)
        addArrangedSubview(historyStack)
        
        landingStack.addArrangedSubview(landingTypeView)
        landingStack.addArrangedSubview(landpadView)
        
        historyStack.addArrangedSubview(statusView)
        historyStack.addArrangedSubview(reusesView)
        historyStack.addArrangedSubview(blockView)
    }
    
    private func configureConstraints() {
        
    }
    
    //MARK: - Update Functions
    private func updateCoreViews() {
        serialLabel.text = core?.serial ?? "Unknown"
        lastUpdateLabel.value = core?.lastUpdate ?? "Unkown"
        statusView.value = core?.status.capitalized ?? "Uknown"
        reusesView.value = "\(core?.reuseCount.description ?? "Unknown")"
        blockView.value = "\(core?.block?.description ?? "Unknown")"
    }
    
    private func updateLaunchCoreViews() {
        landingTypeView.value = launchCore?.landingType ?? "Unknown"
    }
    
    private func updateLandpadViews() {
        landpadView.value = landpad?.name ?? "Unknown"
    }
}
