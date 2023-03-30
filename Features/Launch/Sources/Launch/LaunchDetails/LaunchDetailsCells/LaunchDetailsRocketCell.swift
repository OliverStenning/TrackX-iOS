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

    func configure(viewModel: LaunchDetailsRocketCellModel) {}

    // MARK: Private

    private func setup() {
        backgroundConfiguration = .clear()
        layout()
    }

    private func layout() {}

}
