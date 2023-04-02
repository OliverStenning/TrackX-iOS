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
    private let errorTitleLabel = RKLabel()
    private let errorBodyLabel = RKLabel()
    private let retryButton = RKButton()

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
        errorTitleLabel.text = L10n.ErrorView.Label.title
        errorTitleLabel.fontStyle = .title2
        errorTitleLabel.textAlignment = .center

        errorBodyLabel.text = L10n.ErrorView.Label.body
        errorBodyLabel.textColor = RKAssets.Colors.neutral3.color
        errorBodyLabel.fontStyle = .body
        errorBodyLabel.textAlignment = .center
    }

    private func setupButton() {
        retryButton.text = L10n.ErrorView.Button.retry
        retryButton.image = UIImage(systemSymbol: .arrowClockwise)
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
