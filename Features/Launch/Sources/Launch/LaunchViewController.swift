import Combine
import RaptorKit
import UIKit

// MARK: - LaunchViewController

final class LaunchViewController: UIViewController {
    
    // MARK: - Lifecycle
    
    init(viewModel: LaunchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
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
    
    // MARK: - Private
    
    private typealias DataSource = UITableViewDiffableDataSource<LaunchSection, LaunchCellType>
    
    private let viewModel: LaunchViewModel
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var dataSource = DataSource(tableView: tableView) { tableView, indexPath, launchItem -> UITableViewCell? in
        switch launchItem {
        case let .upcoming(viewModel):
            let cell: UpcomingLaunchCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(viewModel: viewModel)
            return cell
        case let .latest(viewModel):
            let cell: LatestLaunchCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(viewModel: viewModel)
            return cell        }
    }
    
    
    private func setup() {
        navigationItem.title = viewModel.title
        view.backgroundColor = RKAssets.Colors.background1.color
        
        bindViewModel()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(UpcomingLaunchCell.self)
        tableView.register(LatestLaunchCell.self)
        tableView.register(RKLabelHeaderView.self)
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemBackground
        tableView.estimatedSectionHeaderHeight = 100
        tableView.backgroundColor = .clear
    }
    
    private func layout() {
        view.addSubview(tableView)
        tableView.pin(edges: .all, to: view)
    }
    
    private func bindViewModel() {
        viewModel.sectionsPublisher.sink { [weak self] sections in
            guard let self else { return }
            self.updateSections(sections)
        }.store(in: &cancellables)
    }
    
    private func updateSections(_ sections: [LaunchSection]) {
        var snapshot = NSDiffableDataSourceSnapshot<LaunchSection, LaunchCellType>()
        snapshot.appendSections(sections)
        sections.forEach { section in
            switch section {
            case .upcoming:
                snapshot.appendItems([.upcoming(UpcomingLaunchCellViewModel())], toSection: section)
            case .latest:
                snapshot.appendItems([.latest(LatestLaunchCellViewModel())], toSection: section)
            }
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
}

extension LaunchViewController: UITableViewDelegate {
    
    // MARK: - Headers
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionType = dataSource.snapshot().sectionIdentifiers[section]
        guard let sectionTitle = sectionTitle(for: sectionType) else { return nil }
        let headerView: RKLabelHeaderView = tableView.dequeueReusableHeaderFooterView()
        headerView.configure(with: sectionTitle)
        return headerView
    }
    
    private func sectionTitle(for section: LaunchSection) -> String? {
        switch section {
        case .upcoming: return "Upcoming"
        case .latest: return "Latest"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionType = dataSource.snapshot().sectionIdentifiers[section]
        guard sectionTitle(for: sectionType) != nil else { return 0 }
        return UITableView.automaticDimension
    }
    
}
