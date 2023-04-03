import Combine
import RaptorKit
import TrackXClient
import UIKit

// MARK: - LaunchesViewController

final class LaunchesViewController: UIViewController {

    // MARK: Lifecycle

    init(viewModel: LaunchesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: Internal

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    // MARK: Private

    private let viewModel: LaunchesViewModel
    private let scrollView = UIScrollView()
    private let refreshControl = UIRefreshControl()
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    private let pageControl = UIPageControl()
    private let loadingView = RKLoadingView()
    private let errorView = RKErrorView()

    private var settingsButton: UIBarButtonItem?
    private var pages = [UIViewController]()
    private var cancellables = Set<AnyCancellable>()

    private func setup() {
        navigationItem.largeTitleDisplayMode = .never

        setupNavBar()
        setupScrollView()
        setupPager()
        setupPagerControl()
        errorView.action = viewModel.loadLaunches

        layout()
        bindViewModel()
        viewModel.loadLaunches()
    }

    private func setupNavBar() {
        settingsButton = UIBarButtonItem(image: UIImage(systemSymbol: .gearshapeFill), style: .plain, target: self, action: #selector(didTapSettings))
    }

    private func setupScrollView() {
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.refreshControl = refreshControl
        refreshControl.tintColor = RKAssets.Colors.accent3.color
        refreshControl.addTarget(self, action: #selector(refreshLaunches), for: .valueChanged)
    }

    private func setupPager() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
    }

    private func setupPagerControl() {
        pageControl.currentPageIndicatorTintColor = RKAssets.Colors.accent3.color
        updatePagerControl()
    }

    private func layout() {
        view.addSubviews(scrollView, pageControl, loadingView, errorView)
        scrollView.pin(edges: .all, to: view)

        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        scrollView.addSubview(pageViewController.view)
        pageViewController.view.size(.width, to: .width, of: view)
        pageViewController.view.size(.height, to: .height, of: view)

        pageControl.pin(.bottom, to: .bottom, of: view, constant: 32)
        pageControl.center(.horizontal, to: view)

        loadingView.pin(edges: .all, to: view)
        errorView.pin(edges: .all, to: view)
    }

    private func bindViewModel() {
        viewModel.statePublisher.sink { [weak self] state in
            guard let self else { return }
            self.updateState(state)
        }.store(in: &cancellables)

        viewModel.pageModelsPublisher.sink { [weak self] pageModels in
            guard let self else { return }
            self.updatePages(pageModels)
            self.updatePagerControl()
        }.store(in: &cancellables)
    }

    private func updateState(_ state: LaunchesViewModel.State) {
        switch state {
        case .initial: break
        case .loading:
            loadingView.isHidden = false
            errorView.isHidden = true
            navigationItem.rightBarButtonItem = nil
            endRefreshing()
        case .refreshing:
            loadingView.isHidden = true
            errorView.isHidden = true
            navigationItem.rightBarButtonItem = nil
            beginRefreshing()
        case .loaded:
            loadingView.isHidden = true
            errorView.isHidden = true
            navigationItem.rightBarButtonItem = settingsButton
            endRefreshing()
        case .error:
            loadingView.isHidden = true
            errorView.isHidden = false
            navigationItem.rightBarButtonItem = nil
            endRefreshing()
        }
    }

    private func updatePages(_ pageModels: [LaunchPageViewModel]) {
        guard !pageModels.isEmpty else { return }
        pages = pageModels.map { LaunchPageViewController(viewModel: $0) }
        pageViewController.setViewControllers([pages[0]], direction: .forward, animated: false)
    }

    private func updatePagerControl() {
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
    }

    private func beginRefreshing() {
        scrollView.contentInsetAdjustmentBehavior = .automatic
        refreshControl.beginRefreshing()
    }

    private func endRefreshing() {
        scrollView.contentInsetAdjustmentBehavior = .never
        refreshControl.endRefreshing()
    }

    @objc private func refreshLaunches() {
        viewModel.refreshLaunches()
    }

    @objc private func didTapSettings() {
        // TODO: Settings menu
    }
}

// MARK: UIPageViewControllerDataSource

extension LaunchesViewController: UIPageViewControllerDataSource {
    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index > 0 else { return nil }
        return pages[index - 1]
    }

    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else { return nil }
        return pages[index + 1]
    }
}

// MARK: UIPageViewControllerDelegate

extension LaunchesViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating _: Bool, previousViewControllers _: [UIViewController], transitionCompleted _: Bool) {
        if let currentPage = pageViewController.viewControllers?.first, let index = pages.firstIndex(of: currentPage) {
            pageControl.currentPage = index
        }
    }
}
