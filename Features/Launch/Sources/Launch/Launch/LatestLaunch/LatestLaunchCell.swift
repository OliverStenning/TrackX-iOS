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
    private let cardContentView = UIView()
    private let cardBackgroundView = UIView()
    private let headerImageView = UIImageView()
    private let statusView = RKTagView()
    private let launchInfoView = LaunchInfoView()
    private let chevronView = UIImageView()
    
    private func setup() {
        backgroundConfiguration = .clear()
        cardView.layer.cornerRadius = 12
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cardView.layer.shadowRadius = 12
        cardView.layer.shadowOpacity = 0.7

//        cardContentView.backgroundColor = RKAssets.Colors.background1.color
        
        let image: UIImage = RKAssets.Images.placeholder1.image
        
        cardContentView.backgroundColor = image.averageColor ?? RKAssets.Colors.background1.color
        cardContentView.layer.cornerRadius = 12
        cardContentView.clipsToBounds = true
        
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.clipsToBounds = true
        
        cardBackgroundView.backgroundColor = RKAssets.Colors.background1.color
        
        chevronView.image = UIImage(systemName: "chevron.right")
        chevronView.tintColor = RKAssets.Colors.neutral3.color
        
        layout()
    }
    
    private func layout() {
        contentView.addSubview(cardView)
        cardView.addSubview(cardContentView)
        cardContentView.addSubviews(cardBackgroundView, headerImageView, statusView, launchInfoView, chevronView)
        
        cardView.pin(edges: .all, to: contentView, insets: .symmetrical(horizontal: 16))
        cardContentView.pin(edges: .all, to: cardView)
        
        headerImageView.pin(edges: [.top, .leadingAndTrailing], to: cardContentView)
        headerImageView.size(.height, constant: 300)
        
        statusView.pin(edges: [.top, .leading], to: cardContentView, insets: .symmetrical(horizontal: 16, vertical: 16))
        
        chevronView.pin(.trailing, to: .trailing, of: cardContentView, constant: 16)
        chevronView.center(.vertical, to: launchInfoView)
        chevronView.setContentHuggingPriority(.required, for: .horizontal)
        
        launchInfoView.pin(edges: [.leading, .bottom], to: cardContentView)
        launchInfoView.pin(.trailing, to: .leading, of: chevronView)
        launchInfoView.pin(.top, to: .bottom, of: headerImageView)
    }
    
}

