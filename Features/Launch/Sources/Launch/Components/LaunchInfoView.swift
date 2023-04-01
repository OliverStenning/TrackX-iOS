import RaptorKit
import TrackXClient
import UIKit

// MARK: - LaunchInfoView

final class LaunchInfoView: UIView {

    // MARK: Lifecycle

    init(backgroundType: BackgroundType = .automatic) {
        self.backgroundType = backgroundType
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    enum BackgroundType {
        case image
        case automatic
    }

    func configure(with launch: Launch) {
        statusLabel.text = launch.status.name
        switch (launch.status.type, backgroundType) {
        case (.scheduled, .image): statusLabel.textColor = RKAssets.Colors.accent2.color.darkOnly
        case (.scheduled, .automatic): statusLabel.textColor = RKAssets.Colors.accent2.color
        case (.success, _): statusLabel.textColor = RKAssets.Colors.success.color
        case (.failure, _): statusLabel.textColor = RKAssets.Colors.failure.color
        }
        nameLabel.text = launch.name ?? "Unknown"
        dateLabel.text = launch.net ?? "Unknown"
    }

    // MARK: Private

    private let backgroundType: BackgroundType
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
        switch backgroundType {
        case .image:
            nameLabel.textColor = RKAssets.Colors.neutral1.color.darkOnly
            dateLabel.textColor = RKAssets.Colors.neutral3.color.darkOnly
        case .automatic:
            nameLabel.textColor = RKAssets.Colors.neutral1.color
            dateLabel.textColor = RKAssets.Colors.neutral3.color
        }

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
