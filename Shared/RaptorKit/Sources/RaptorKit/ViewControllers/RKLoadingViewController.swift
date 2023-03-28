import UIKit

// MARK: - RKLoadingViewController

public final class RKLoadingViewController: UIViewController {
    
    // MARK: - Lifecycle
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        super.loadView()
        layout()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Private
    
    private let loadingView = RKLoadingView()
    
    private func setup() {
        loadingView.backgroundColor = RKAssets.Colors.background1.color
    }
    
    private func layout() {
        view.addSubview(loadingView)
        loadingView.pin(edges: .all, to: view)
    }
    
}
