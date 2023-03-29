import SFSafeSymbols
import UIKit

// MARK: - RKErrorView

public final class RKErrorView: UIView {

    // MARK: Lifecycle

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public

    public var action: (() -> Void)?

    // MARK: Private

    private let containerView = UIView()
    private let errorIcon = UIImageView()
    private let errorTitleLabel = UILabel()
    private let errorBodyLabel = UILabel()
    private let retryButton = UIButton()

    private func setup() {
        backgroundColor = RKAssets.Colors.background1.color
        setupIcon()
        setupLabels()
        setupButton()
        layout()
    }

    private func setupIcon() {
        errorIcon.image = RKAssets.Images.launchScreenIcon.image
        errorIcon.tintColor = RKAssets.Colors.neutral1.color
        errorIcon.contentMode = .scaleAspectFit
    }

    private func setupLabels() {
        errorTitleLabel.text = "Something went wrong"
        errorTitleLabel.textColor = RKAssets.Colors.neutral1.color
        errorTitleLabel.font = RKFonts.Poppins.semiBold.font(size: 24)
        errorTitleLabel.textAlignment = .center
        errorTitleLabel.numberOfLines = 0

        errorBodyLabel.text = "Check your network connection and try again."
        errorBodyLabel.textColor = RKAssets.Colors.neutral3.color
        errorBodyLabel.font = RKFonts.Rubik.regular.font(size: 16)
        errorBodyLabel.textAlignment = .center
        errorBodyLabel.numberOfLines = 0
    }

    private func setupButton() {
        var buttonConfig = UIButton.Configuration.filled()
        buttonConfig.titleAlignment = .center
        buttonConfig.contentInsets = .symmetrical(horizontal: 64, vertical: 8)
        buttonConfig.baseBackgroundColor = RKAssets.Colors.accent3.color
        buttonConfig.baseForegroundColor = RKAssets.Colors.neutral1.color.darkOnly
        buttonConfig.cornerStyle = .medium

        var buttonText = AttributedString("Retry")
        buttonText.font = RKFonts.SpaceGrotesk.medium.font(size: 18)
        buttonConfig.attributedTitle = buttonText

        buttonConfig.image = UIImage(systemSymbol: .arrowClockwise, withConfiguration: UIImage.SymbolConfiguration(scale: .medium))
        buttonConfig.imagePlacement = .leading
        buttonConfig.imagePadding = 8.0

        retryButton.configuration = buttonConfig
        retryButton.addTarget(self, action: #selector(retryAction), for: .touchUpInside)
    }

    private func layout() {
        addSubview(containerView)
        containerView.center(.horizontal, to: self)
        containerView.center(.vertical, to: self)
        containerView.size(.width, relation: .lessThanOrEqual, constant: 300)
        containerView.pin(.leading, to: .leading, of: self, constant: 32, relation: .greaterThanOrEqual, priority: .defaultHigh)
        containerView.pin(.trailing, to: .trailing, of: self, constant: 32, relation: .greaterThanOrEqual, priority: .defaultHigh)

        containerView.addSubviews(errorIcon, errorTitleLabel, errorBodyLabel, retryButton)

        errorIcon.pin(.top, to: .top, of: containerView)
        errorIcon.center(.horizontal, to: containerView)
        errorIcon.size(.width, to: .width, of: self, multiplier: 0.5)
        errorIcon.size(.height, to: .width, of: errorIcon)

        errorTitleLabel.pin(edges: .leadingAndTrailing, to: containerView)
        errorTitleLabel.pin(.top, to: .bottom, of: errorIcon, constant: -16)

        errorBodyLabel.pin(edges: .leadingAndTrailing, to: containerView)
        errorBodyLabel.pin(.top, to: .bottom, of: errorTitleLabel, constant: -8)

        retryButton.pin(edges: .bottom, to: containerView)
        retryButton.center(.horizontal, to: containerView)
        retryButton.pin(.top, to: .bottom, of: errorBodyLabel, constant: -64)
    }

    @objc private func retryAction() {
        guard let action else { return }
        action()
    }
}
