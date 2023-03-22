import RaptorKit
import UIKit

// MARK: - LaunchDetailsHeaderCell

final class LaunchDetailsHeaderCell: UITableViewCell {
    
    // MARK: - Lifecycle
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal
    
    func configure(viewModel: LaunchDetailsHeaderCellViewModel) {
        backgroundImage.image = RKAssets.Images.placeholder.image
    }
    
    // MARK: - Private
    
    private let backgroundImage = UIImageView()
    private let backgroundGradient = RKGradientView()

    
    private var hideGradient: Bool {
//        traitCollection.userInterfaceStyle != .dark
        true
    }
    
    private func setup() {
        layout()
        setupBackground()
    }
    
    private func setupBackground() {
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        
        backgroundGradient.isHidden = hideGradient
    }
    
    private func layout() {
        contentView.addSubviews(backgroundImage, backgroundGradient)
        
        backgroundImage.pin(edges: .all, to: contentView)
        backgroundGradient.pin(edges: .all, to: contentView)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        backgroundGradient.isHidden = hideGradient
    }
    
}

