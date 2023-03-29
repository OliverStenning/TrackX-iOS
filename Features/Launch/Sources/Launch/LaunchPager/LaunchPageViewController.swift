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
    private var statusLabel = RKLabel()
    private var separatorView = UIView()
    private var launchNameLabel = RKLabel()
    private var launchDateLabel = RKLabel()
    private var viewDetailsButton = RKButton()

    private func setup() {
        setupBackground()
        setupLabels()
        setupSeparator()
        setupButton()
    }

    private func setupBackground() {
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.image = RKAssets.Images.placeholder1.image

        backgroundGradientView.topColor = UIColor(red: 28 / 255, green: 28 / 255, blue: 30 / 255, alpha: 0.35)
        backgroundGradientView.bottomColor = UIColor(red: 23 / 255, green: 23 / 255, blue: 33 / 255, alpha: 1).darkOnly
    }

    private func setupLabels() {
//        statusLabel.text = "Upcoming"
//        statusLabel.font = RKFonts.SpaceGrotesk.bold.font(size: 32)
//        statusLabel.textColor = RKAssets.Colors.accent2.color.darkOnly

        statusLabel.text = "Success"
        statusLabel.fontStyle = .title1
        statusLabel.textColor = RKAssets.Colors.success.color.darkOnly

        launchNameLabel.text = "Falcon 9 Block 5 | Starlink Group 5-10"
        launchNameLabel.fontStyle = .largeTitle
        launchNameLabel.textColor = RKAssets.Colors.neutral1.color.darkOnly

        launchDateLabel.text = "20:11 UTC - 29th March"
        launchDateLabel.fontStyle = .title3
        launchDateLabel.textColor = RKAssets.Colors.neutral3.color.darkOnly
    }

    private func setupSeparator() {
        separatorView.backgroundColor = RKAssets.Colors.neutral2.color.darkOnly
    }

    private func setupButton() {
        viewDetailsButton.text = "View details"
        viewDetailsButton.image = UIImage(systemSymbol: .chevronUpSquareFill)
        viewDetailsButton.addTarget(self, action: #selector(didTapViewDetails), for: .touchUpInside)
    }

    private func layout() {
        view.addSubviews(backgroundImageView, backgroundGradientView, statusLabel, separatorView, launchNameLabel, launchDateLabel, viewDetailsButton)

        backgroundImageView.pin(edges: .all, to: view)
        backgroundGradientView.pin(edges: .all, to: view)

        statusLabel.pin(edges: .leadingAndTrailing, to: view, insets: .symmetrical(horizontal: 24))
        statusLabel.pin(.bottom, to: .top, of: separatorView, constant: 8)

        separatorView.size(.height, constant: 4)
        separatorView.size(.width, constant: 64)
        separatorView.pin(edges: .leading, to: view, insets: .symmetrical(horizontal: 24))
        separatorView.pin(.bottom, to: .top, of: launchNameLabel, constant: 8)

        launchNameLabel.pin(edges: .leadingAndTrailing, to: view, insets: .symmetrical(horizontal: 24))
        launchNameLabel.pin(.bottom, to: .top, of: launchDateLabel, constant: 8)

        launchDateLabel.pin(edges: .leadingAndTrailing, to: view, insets: .symmetrical(horizontal: 24))
        launchDateLabel.pin(.bottom, to: .top, of: viewDetailsButton, constant: 24)

        viewDetailsButton.pin(edges: .leading, to: view, insets: .symmetrical(horizontal: 24))
        viewDetailsButton.pin(.bottom, to: .bottom, of: view, constant: 96)
    }

    @objc private func didTapViewDetails() {
        viewModel.didTapViewDetails()
    }
}
