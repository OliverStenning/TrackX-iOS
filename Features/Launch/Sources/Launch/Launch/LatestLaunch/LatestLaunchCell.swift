import RaptorKit
import UIKit

// MARK: - LatestLaunchCell

final class LatestLaunchCell: UITableViewCell {
    
    // MARK: - Lifecycle
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal
    
    func configure(viewModel: LatestLaunchCellViewModel) {
        headerImageView.image = RKAssets.Images.placeholder1.image
        
        statusView.text = "Success"
        statusView.backgroundColor = RKAssets.Colors.success.color
        
        launchInfoView.configure(with: viewModel.launchInfoViewModel)
    }
    
    // MARK: - Private
    
    private let cardView = UIView()
    private let cardBackgroundView = UIView()
    private let headerImageView = UIImageView()
    private let statusView = RKTagView()
    private let launchInfoView = LaunchInfoView()
    private let chevronView = UIImageView()
    
    private func setup() {
        backgroundConfiguration = .clear()
        cardView.layer.cornerRadius = 12
        cardView.clipsToBounds = true

        headerImageView.contentMode = .scaleAspectFill
        headerImageView.clipsToBounds = true
        
        cardBackgroundView.backgroundColor = RKAssets.Colors.background2.color
        
        chevronView.image = UIImage(systemName: "chevron.right")
        chevronView.tintColor = RKAssets.Colors.neutral3.color
        
        layout()
    }
    
    private func layout() {
        contentView.addSubview(cardView)
        cardView.addSubviews(cardBackgroundView, headerImageView, statusView, launchInfoView, chevronView)
        
        cardView.pin(edges: .all, to: contentView, insets: .symmetrical(horizontal: 16))
        cardBackgroundView.pin(edges: .all, to: cardView)
        
        headerImageView.pin(edges: [.top, .leadingAndTrailing], to: cardView)
        headerImageView.size(.height, constant: 200)
        
        statusView.pin(edges: [.top, .leading], to: cardView, insets: .symmetrical(horizontal: 16, vertical: 16))
        
        chevronView.pin(.trailing, to: .trailing, of: cardView, constant: 16)
        chevronView.center(.vertical, to: launchInfoView)
        chevronView.setContentHuggingPriority(.required, for: .horizontal)
        
        launchInfoView.pin(edges: [.leading, .bottom], to: cardView)
        launchInfoView.pin(.trailing, to: .leading, of: chevronView)
        launchInfoView.pin(.top, to: .bottom, of: headerImageView)
    }
    
}

