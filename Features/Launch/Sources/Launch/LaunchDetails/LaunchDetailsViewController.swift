import Combine
import RaptorKit
import UIKit

// MARK: - LaunchDetailsViewController

final class LaunchDetailsViewController: UIViewController {

    // MARK: Lifecycle

    init(viewModel: LaunchDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        layout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: Private

    private typealias DataSource = UITableViewDiffableDataSource<LaunchDetailsSection, LaunchDetailsCellType>

    private let closeButton = RKIconButton()
    private let viewModel: LaunchDetailsViewModel
    private let tableView = UITableView(frame: .zero, style: .grouped)

    private var cancellables = Set<AnyCancellable>()

    private lazy var dataSource = DataSource(tableView: tableView) { tableView, indexPath, launchDetailsItem -> UITableViewCell? in
        switch launchDetailsItem {
        case let .launch(viewModel):
            let cell: LaunchDetailsLaunchCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(viewModel: viewModel)
            return cell
        case let .rocket(viewModel):
            let cell: LaunchDetailsRocketCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(viewModel: viewModel)
            return cell
        case let .launchpad(viewModel):
            let cell: LaunchDetailsLaunchpadCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(viewModel: viewModel)
            return cell
        }
    }

    private func setup() {
        view.backgroundColor = RKAssets.Colors.background1.color

        bindViewModel()
        setupCloseButton()
        setupTableView()
    }

    private func setupCloseButton() {
        closeButton.image = UIImage(systemSymbol: .xmark)
        closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
    }

    private func setupTableView() {
        tableView.register(LaunchDetailsLaunchCell.self)
        tableView.register(LaunchDetailsRocketCell.self)
        tableView.register(LaunchDetailsLaunchpadCell.self)
        tableView.register(RKLabelHeaderView.self)
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemBackground
        tableView.estimatedSectionHeaderHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.insetsContentViewsToSafeArea = false
    }

    private func layout() {
        view.addSubviews(tableView, closeButton)
        tableView.pin(edges: .all, to: view, safeAreaEdges: [.top])

        closeButton.pin(edges: [.top, .trailing], to: view, insets: .only(top: 24, right: 24))
    }

    private func bindViewModel() {
        viewModel.sectionsPublisher.sink { [weak self] sections in
            guard let self else { return }
            self.updateSections(sections)
        }.store(in: &cancellables)
    }

    private func updateSections(_ sections: [LaunchDetailsSection]) {
        var snapshot = NSDiffableDataSourceSnapshot<LaunchDetailsSection, LaunchDetailsCellType>()
        snapshot.appendSections(sections)
        sections.forEach { section in
            switch section {
            case let .launch(viewModel):
                snapshot.appendItems([.launch(viewModel)], toSection: section)
            case let .rocket(viewModel):
                snapshot.appendItems([.rocket(viewModel)], toSection: section)
            case let .launchpad(viewModel):
                snapshot.appendItems([.launchpad(viewModel)], toSection: section)
            }
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    @objc private func didTapClose() {
        dismiss(animated: true)
    }

}

// MARK: UITableViewDelegate

extension LaunchDetailsViewController: UITableViewDelegate {
    // MARK: - Headers

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionType = dataSource.snapshot().sectionIdentifiers[section]
        guard let sectionTitle = sectionTitle(for: sectionType) else { return nil }
        let headerView: RKLabelHeaderView = tableView.dequeueReusableHeaderFooterView()
        headerView.configure(with: sectionTitle)
        return headerView
    }

    private func sectionTitle(for section: LaunchDetailsSection) -> String? {
        switch section {
        case .launch: return nil
        case .rocket: return L10n.LaunchDetails.Header.rocket
        case .launchpad: return L10n.LaunchDetails.Header.launchpad
        }
    }

    func tableView(_: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionType = dataSource.snapshot().sectionIdentifiers[section]
        guard sectionTitle(for: sectionType) != nil else { return 0 }
        return UITableView.automaticDimension
    }

}
