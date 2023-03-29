import RaptorKit
import UIKit

// MARK: - LaunchDetailsLaunchCell

final class LaunchDetailsLaunchCell: UITableViewCell {

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

    func configure(viewModel: LaunchDetailsLaunchCellViewModel) {
        nameLabel.label.text = viewModel.launch.name
        dateLabel.text = viewModel.launch.dateUtc
    }

    // MARK: Private

    private let nameLabel = RKCapsuleLabel()
    private let dateLabel = UILabel()

    private func setup() {
        layout()
        setupLabels()

        backgroundConfiguration = .clear()
    }

    private func setupLabels() {
        nameLabel.label.font = RKFonts.Poppins.medium.font(size: 30)
        dateLabel.font = RKFonts.Poppins.medium.font(size: 18)
        dateLabel.textColor = RKAssets.Colors.neutral5.color
    }

    private func layout() {
        contentView.addSubviews(nameLabel, dateLabel)

        nameLabel.pin(edges: [.leadingAndTrailing, .top], to: contentView, insets: .symmetrical(horizontal: 16, vertical: 8))

        dateLabel.pin(.top, to: .bottom, of: nameLabel, constant: -8)
        dateLabel.pin(edges: [.bottom, .leadingAndTrailing], to: contentView, insets: .symmetrical(horizontal: 16, vertical: 0))
    }
}
