import RaptorKit
import UIKit

// MARK: - LaunchCountdownView

final class LaunchCountdownView: UIView {
    
    // MARK: - Lifecycle
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: LaunchCountdownViewModel) {
        nameLabel.text = viewModel.name
        for timeUnitModel in viewModel.timeUnitModels {
            let timeUnitView = TimeUnitView()
            timeUnitView.configure(with: timeUnitModel)
            timeUnitsStack.addArrangedSubview(timeUnitView)
        }
    }
    
    // MARK: - Private
    
    private let nameLabel = UILabel()
    private let timeUnitsStack = UIStackView()
    
    private func setup() {
        backgroundColor = RKAssets.Colors.accent3.color
//        layer.cornerRadius = 12
        setupLabels()
        setupStackView()
        layout()
    }
    
    private func setupLabels() {
        nameLabel.textColor = RKAssets.Colors.neutral2.color.darkOnly
        nameLabel.font = RKFonts.Archivo.semiBold.font(size: 16)
    }
    
    private func setupStackView() {
        timeUnitsStack.axis = .horizontal
        timeUnitsStack.distribution = .equalCentering
    }
    
    private func layout() {
        addSubviews(nameLabel, timeUnitsStack)
        
        nameLabel.pin(edges: [.top, .leadingAndTrailing], to: self, insets: .only(top: 16, left: 16, right: 16))
        timeUnitsStack.pin(edges: [.bottom, .leadingAndTrailing], to: self, insets: .only(left: 16, bottom: 8, right: 32))
        timeUnitsStack.pin(.top, to: .bottom, of: nameLabel, constant: -4)
    }
    
}
