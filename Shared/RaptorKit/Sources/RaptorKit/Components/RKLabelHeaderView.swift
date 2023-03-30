import UIKit

// MARK: - RKLabelHeaderView

public final class RKLabelHeaderView: UITableViewHeaderFooterView {

    // MARK: Lifecycle

    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public

    public func configure(with title: String) {
        titleLabel.text = title
    }

    // MARK: Private

    private let titleLabel = RKLabel()

    private func setup() {
        titleLabel.textColor = RKAssets.Colors.neutral2.color
        titleLabel.fontStyle = .title1

        contentView.addSubview(titleLabel)
        titleLabel.pin(edges: .all, to: contentView, insets: .only(top: 24, left: 24, bottom: 8, right: 24))
    }
}
