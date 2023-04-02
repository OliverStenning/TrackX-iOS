import RaptorKit
import TrackXClient
import UIKit
import Utilities

// MARK: - LaunchInfoView

final class LaunchInfoView: UIView {

    // MARK: Lifecycle

    init() {
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    func configure(with viewModel: LaunchInfoViewModel) {
        statusLabel.text = viewModel.statusText
        nameLabel.text = viewModel.nameText
        dateLabel.text = viewModel.dateText

        statusLabel.textColor = viewModel.statusColor
        nameLabel.textColor = viewModel.nameColor
        dateLabel.textColor = viewModel.dateColor
    }

    // MARK: Private

    private let statusLabel = RKLabel()
    private let separatorView = UIView()
    private let nameLabel = RKLabel()
    private let dateLabel = RKLabel()

    private func setup() {
        setupLabels()
        separatorView.backgroundColor = RKAssets.Colors.neutral2.color.darkOnly
        layout()
    }

    private func setupLabels() {
        statusLabel.fontStyle = .title1
        nameLabel.fontStyle = .largeTitle
        dateLabel.fontStyle = .title3
    }

    private func layout() {
        addSubviews(statusLabel, separatorView, nameLabel, dateLabel)

        statusLabel.pin(edges: [.leadingAndTrailing, .top], to: self)
        statusLabel.pin(.bottom, to: .top, of: separatorView, constant: 16)

        separatorView.size(.height, constant: 4)
        separatorView.size(.width, constant: 64)
        separatorView.pin(edges: .leading, to: self)
        separatorView.pin(.bottom, to: .top, of: nameLabel, constant: 16)

        nameLabel.pin(edges: .leadingAndTrailing, to: self)
        nameLabel.pin(.bottom, to: .top, of: dateLabel, constant: 8)

        dateLabel.pin(edges: [.leadingAndTrailing, .bottom], to: self)
    }

}
