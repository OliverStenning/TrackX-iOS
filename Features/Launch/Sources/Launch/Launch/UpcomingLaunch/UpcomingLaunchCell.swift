import RaptorKit
import UIKit

// MARK: - UpcomingLaunchCell

final class UpcomingLaunchCell: UITableViewCell {
    
    // MARK: - Lifecycle
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal
    
    func configure(viewModel: UpcomingLaunchCellViewModel) {
        launchCountdownView.configure(with: LaunchCountdownViewModel(launch: viewModel.launch))
        launchInfoView.configure(with: viewModel.launchInfoViewModel)
    }
    
    // MARK: - Private
    
    private let cardView = UIView()
    private let launchCountdownView = LaunchCountdownView()
    private let launchInfoView = LaunchInfoView()
    private let chevronView = UIImageView()
    
    private func setup() {
        layout()
        backgroundConfiguration = .clear()
        cardView.backgroundColor = RKAssets.Colors.background2.color
        cardView.layer.cornerRadius = 12
        cardView.clipsToBounds = true
        
        chevronView.image = UIImage(systemName: "chevron.right")
        chevronView.tintColor = RKAssets.Colors.neutral3.color
    }
    
    private func layout() {
        addSubview(cardView)
        cardView.addSubviews(launchCountdownView, launchInfoView, chevronView)
        
        cardView.pin(edges: .all, to: self, insets: .symmetrical(horizontal: 16))
        launchCountdownView.pin(edges: [.top, .leadingAndTrailing], to: cardView)
        
        chevronView.pin(.trailing, to: .trailing, of: cardView, constant: 16)
        chevronView.center(.vertical, to: launchInfoView)
        chevronView.setContentHuggingPriority(.required, for: .horizontal)
        
        launchInfoView.pin(edges: [.leading, .bottom], to: cardView)
        launchInfoView.pin(.trailing, to: .leading, of: chevronView)
        launchInfoView.pin(.top, to: .bottom, of: launchCountdownView, constant: -8)
    }
    
}

