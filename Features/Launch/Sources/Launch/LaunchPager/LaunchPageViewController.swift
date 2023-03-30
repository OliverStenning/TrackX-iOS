import RaptorKit
import SFSafeSymbols
import UIKit

// MARK: - LaunchPageViewController

final class LaunchPageViewController: UIViewController {

    // MARK: Lifecycle

    init(viewModel: LaunchPageViewModel) {
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

    private let viewModel: LaunchPageViewModel

    private var backgroundImageView = UIImageView()
    private var backgroundGradientView = RKGradientView()
    private var launchInfoView = LaunchInfoView(backgroundType: .image)
    private var viewDetailsButton = RKButton()

    private func setup() {
        setupBackground()
        setupButton()
        launchInfoView.configure(with: viewModel.launch)
    }

    private func setupBackground() {
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.image = RKAssets.Images.placeholder1.image

        backgroundGradientView.topColor = UIColor(red: 28 / 255, green: 28 / 255, blue: 30 / 255, alpha: 0.35)
        backgroundGradientView.bottomColor = UIColor(red: 23 / 255, green: 23 / 255, blue: 33 / 255, alpha: 1).darkOnly
    }

    private func setupButton() {
        viewDetailsButton.text = "View details"
        viewDetailsButton.image = UIImage(systemSymbol: .chevronUpSquareFill)
        viewDetailsButton.addTarget(self, action: #selector(didTapViewDetails), for: .touchUpInside)
    }

    private func layout() {
        view.addSubviews(backgroundImageView, backgroundGradientView, launchInfoView, viewDetailsButton)

        backgroundImageView.pin(edges: .all, to: view)
        backgroundGradientView.pin(edges: .all, to: view)

        launchInfoView.pin(edges: .leadingAndTrailing, to: view, insets: .symmetrical(horizontal: 24))
        launchInfoView.pin(.bottom, to: .top, of: viewDetailsButton, constant: 24)

        viewDetailsButton.pin(edges: .leading, to: view, insets: .symmetrical(horizontal: 24))
        viewDetailsButton.pin(.bottom, to: .bottom, of: view, constant: 96)
    }

    @objc private func didTapViewDetails() {
        viewModel.didTapViewDetails()
    }
}
