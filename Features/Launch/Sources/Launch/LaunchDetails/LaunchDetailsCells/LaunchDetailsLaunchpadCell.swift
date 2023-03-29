import RaptorKit
import UIKit

// MARK: - LaunchDetailsLaunchpadCell

final class LaunchDetailsLaunchpadCell: UITableViewCell {
    // MARK: - Lifecycle

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal

    func configure(viewModel _: LaunchDetailsLaunchpadCellViewModel) {}

    // MARK: - Private

    private let cardView = UIView()
    private let label = UILabel()

    private func setup() {
        layout()
        backgroundConfiguration = .clear()
        cardView.backgroundColor = RKAssets.Colors.background2.color
        cardView.layer.cornerRadius = 12

        label.text = "Launchpad Info"
        label.textAlignment = .center
    }

    private func layout() {
        addSubview(cardView)
        cardView.addSubview(label)

        cardView.pin(edges: .all, to: self, insets: .symmetrical(horizontal: 16))
        label.pin(edges: .all, to: cardView, insets: .all(16))
    }
}
