import UIKit

// MARK: - RKLabelHeaderView

public final class RKLabelHeaderView: UITableViewHeaderFooterView {
    // MARK: - Lifecycle

    override public init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    public func configure(with title: String) {
        titleLabel.text = title
    }

    // MARK: - Private

    private let titleLabel = UILabel()

    private func setup() {
        titleLabel.textColor = RKAssets.Colors.neutral2.color
        titleLabel.font = RKFonts.Archivo.medium.font(size: 22)

        contentView.addSubview(titleLabel)
        titleLabel.pin(edges: .all, to: contentView, insets: .only(top: 8, left: 16, bottom: 8, right: 16))
    }
}