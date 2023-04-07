import RaptorKit
import UIKit

// MARK: - LaunchDetailsMissionCell

final class LaunchDetailsMissionCell: UITableViewCell {

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

    func configure(viewModel: LaunchDetailsMissionCellModel) {}

    // MARK: Private

    private func setup() {
        backgroundConfiguration = .clear()
        layout()
    }

    private func layout() {}

}
