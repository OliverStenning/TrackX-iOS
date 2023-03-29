import UIKit

// MARK: - RKButtonStyle

public enum RKButtonStyle {

    case primary
    case secondary

    // MARK: Internal

    var backgroundColor: UIColor {
        switch self {
        case .primary: return RKAssets.Colors.accent3.color
        case .secondary: return RKAssets.Colors.neutral5.color
        }
    }

    var foregroundColor: UIColor {
        switch self {
        case .primary: return RKAssets.Colors.neutral1.color.darkOnly
        case .secondary: return RKAssets.Colors.neutral1.color.darkOnly
        }
    }

}

// MARK: - RKButton

public final class RKButton: UIButton {

    // MARK: Lifecycle

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public

    public var text: String = "" {
        didSet {
            updateButtonConfiguration()
        }
    }

    public var buttonStyle: RKButtonStyle = .primary {
        didSet {
            updateButtonConfiguration()
        }
    }

    public var image: UIImage? {
        didSet {
            updateButtonConfiguration()
        }
    }

    // MARK: Private

    private func setup() {
        updateButtonConfiguration()
    }

    private func updateButtonConfiguration() {
        var config = UIButton.Configuration.filled()
        config.titleAlignment = .center
        config.contentInsets = .symmetrical(horizontal: 24, vertical: 8)
        config.baseBackgroundColor = buttonStyle.backgroundColor
        config.baseForegroundColor = buttonStyle.foregroundColor
        config.cornerStyle = .medium

        var buttonText = AttributedString(text)
        buttonText.font = RKFontStyle.button.uiFont
        config.attributedTitle = buttonText

        config.image = image?.withConfiguration(UIImage.SymbolConfiguration(scale: .medium))
        config.imagePlacement = .leading
        config.imagePadding = 8.0

        configuration = config
    }

}
