import RaptorKit
import TrackXClient
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

    func configure(viewModel: LaunchDetailsLaunchCellModel) {
//        launchInfoView.configure(with: viewModel.launch)
    }

    // MARK: Private

    private let launchInfoView = LaunchInfoView()

    private func setup() {
        layout()
        backgroundConfiguration = .clear()
    }

    private func layout() {
        contentView.addSubviews(launchInfoView)
        launchInfoView.pin(edges: .all, to: contentView, insets: .only(top: 32, left: 24, bottom: 0, right: 24))
    }
}
