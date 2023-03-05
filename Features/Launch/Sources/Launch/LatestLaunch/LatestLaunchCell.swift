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
        nameLabel.text = viewModel.name
        rocketLabel.text = viewModel.rocket
        launchpadLabel.text = viewModel.launchpad
    }
    
    // MARK: - Private
    
    private let nameLabel = UILabel()
    private let rocketLabel = UILabel()
    private let launchpadLabel = UILabel()
    
    private func setup() {
        layout()
    }
    
    private func setupLabels() {
        nameLabel.textColor = .label
        rocketLabel.textColor = .label
        launchpadLabel.textColor = .label
    }
    
    private func layout() {
        addSubviews(nameLabel, rocketLabel, launchpadLabel)
        
        nameLabel.pin(edges: [.top, .leadingAndTrailing], to: self)
        
        rocketLabel
            .pin(edges: .leadingAndTrailing, to: self)
            .pin(.top, to: .bottom, of: nameLabel)
        
        launchpadLabel
            .pin(edges: [.leadingAndTrailing, .bottom], to: self)
            .pin(.top, to: .bottom, of: rocketLabel)
        
    }
    
}

