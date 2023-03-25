import RaptorKit
import UIKit

// MARK: - TimeUnitView

final class TimeUnitView: UIView {
    
    // MARK: - Lifecycle
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with timeUnitModel: LaunchCountdownViewModel.TimeUnitModel) {
        timeLabel.text = timeUnitModel.time
        unitLabel.text = timeUnitModel.unit
    }
    
    // MARK: - Private
    
    private let timeLabel = UILabel()
    private let unitLabel = UILabel()
    
    private func setup() {
        setupLabels()
        layout()
    }
    
    private func setupLabels() {
        timeLabel.textColor = RKAssets.Colors.neutral1.color.darkOnly
        timeLabel.font = RKFonts.Archivo.bold.font(size: 36)
        
        unitLabel.textColor = RKAssets.Colors.neutral2.color.darkOnly
        unitLabel.font = RKFonts.Archivo.semiBold.font(size: 16)
    }
    
    private func layout() {
        addSubviews(timeLabel, unitLabel)
        
        timeLabel.pin(edges: [.topAndBottom, .leading], to: self)
        unitLabel.pin(edges: [.trailing], to: self)
        unitLabel.pin(.leading, to: .trailing, of: timeLabel, constant: -4)
        unitLabel.lastBaselineAnchor.constraint(equalTo: timeLabel.lastBaselineAnchor).isActive = true
    }
    
}
