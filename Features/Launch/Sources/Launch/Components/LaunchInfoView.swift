import RaptorKit
import UIKit

final class LaunchInfoView: UIView {
    
    // MARK: - Lifecycle
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: LaunchInfoViewModel) {
        nameLabel.label.text = viewModel.name
        rocketLabel.text = viewModel.rocket
        launchpadLabel.label.text = viewModel.launchpad
        dateLabel.label.text = viewModel.date
    }
    
    // MARK: - Private
    
    private let nameLabel = RKCapsuleLabel()
    private let rocketLabel = UILabel()
    private let launchpadLabel = RKIconLabel()
    private let dateLabel = RKIconLabel()
    
    private func setup() {
        setupLabels()
        layout()
    }
    
    private func setupLabels() {
        rocketLabel.textColor = RKAssets.Colors.neutral1.color
        rocketLabel.font = RKFonts.Archivo.medium.font(size: 20)
        
        launchpadLabel.icon.image = UIImage(systemName: "map.fill")
        dateLabel.icon.image = UIImage(systemName: "calendar")
    }
    
    private func layout() {
        addSubviews(nameLabel, rocketLabel, launchpadLabel, dateLabel)
        
        nameLabel.pin(edges: [.top, .leadingAndTrailing], to: self, insets: .only(top: 16, left: 16, right: 16))
        
        rocketLabel.pin(edges: .leadingAndTrailing, to: self, insets: .symmetrical(horizontal: 16))
        rocketLabel.pin(.top, to: .bottom, of: nameLabel, constant: -8)
        
        launchpadLabel.pin(edges: [.leadingAndTrailing], to: self, insets: .symmetrical(horizontal: 16))
        launchpadLabel.pin(.top, to: .bottom, of: rocketLabel, constant: -8)
        
        dateLabel.pin(edges: [.leadingAndTrailing, .bottom], to: self, insets: .only(left: 16, bottom: 16, right: 16))
        dateLabel.pin(.top, to: .bottom, of: launchpadLabel, constant: -8)
    }
    
}
