import RaptorKit
import TrackXClient
import UIKit

final class LaunchPagerViewController: UIViewController {
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: - Private
    
    private var pageViewController: UIPageViewController?
    private var pages = [UIViewController]()
    private var pageControl = UIPageControl()
    
    private func setup() {
        
        
        let firstPage = LaunchPageViewController()
        let secondPage = LaunchPageViewController()
        let thirdPage = LaunchPageViewController()
        pages = [firstPage, secondPage, thirdPage]
        
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController?.dataSource = self
        pageViewController?.delegate = self
        addChild(pageViewController!)
        view.addSubview(pageViewController!.view)
        pageViewController?.didMove(toParent: self)
        
        pageViewController?.setViewControllers([pages[0]], direction: .forward, animated: false, completion: nil)
        
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = RKAssets.Colors.accent3.color
        view.addSubview(pageControl)
        pageControl.pin(.bottom, to: .bottom, of: view, constant: 20)
        pageControl.center(.horizontal, to: view)
    }
    
}

extension LaunchPagerViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        return pages[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else {
            return nil
        }
        return pages[index + 1]
    }
    
}

extension LaunchPagerViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentPage = pageViewController.viewControllers?.first, let index = pages.firstIndex(of: currentPage) {
            pageControl.currentPage = index
        }
    }
    
}
