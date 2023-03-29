import RaptorKit
import UIKit

// MARK: - LaunchDetailsRocketCell

final class LaunchDetailsRocketCell: UITableViewCell {

    // MARK: Lifecycle

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    func configure(viewModel: LaunchDetailsRocketCellViewModel) {
        nameLabel.value = viewModel.launch.rocket.name ?? "Unknown"
        descriptionLabel.value = "Falcon 9 is a two-stage rocket designed and manufactured by SpaceX for the reliable and safe transport of satellites and the Dragon spacecraft."
    }

    // MARK: Private

    private let cardView = UIView()
    private let nameLabel = RKNamedLabel()
    private let descriptionLabel = RKNamedLabel()

    private func setup() {
        setupCard()
        setupLabels()
        layout()
    }

    private func setupCard() {
        backgroundConfiguration = .clear()
//        cardView.backgroundColor = RKAssets.Colors.background2.color
        cardView.layer.cornerRadius = 12
    }

    private func setupLabels() {
        nameLabel.name = "Name"
        descriptionLabel.name = "Description"
    }

    private func layout() {
        addSubview(cardView)
        cardView.addSubviews(nameLabel, descriptionLabel)

        cardView.pin(edges: .all, to: self, insets: .symmetrical(horizontal: 0))
        nameLabel.pin(edges: [.leadingAndTrailing, .top], to: cardView, insets: .symmetrical(horizontal: 16, vertical: 4))
        descriptionLabel.pin(.top, to: .bottom, of: nameLabel, constant: -8)
        descriptionLabel.pin(edges: [.leadingAndTrailing, .bottom], to: cardView, insets: .all(16))
    }
}
