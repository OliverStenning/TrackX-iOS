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
    
    // MARK: - Internal
    
    let viewModel: LaunchViewModel
    
    // MARK: - Private
    
    private func setup() {
        navigationItem.title = viewModel.title
        view.backgroundColor = .systemBackground
    }
    
    private func layout() {
        
    }
    
}
