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
        launchInfoView.configure(with: LaunchInfoViewModel())
    }
    
    // MARK: - Private
    
    private let cardView = UIView()
    private let launchInfoView = LaunchInfoView()
    
    private func setup() {
        layout()
        backgroundConfiguration = .clear()
        cardView.backgroundColor = .secondarySystemBackground
        cardView.layer.cornerRadius = 12
    }
    
    private func layout() {
        addSubview(cardView)
        cardView.addSubview(launchInfoView)
        
        cardView.pin(edges: .all, to: self, insets: .symmetrical(horizontal: 16))
        launchInfoView.pin(edges: .all, to: cardView)
    }
    
}

