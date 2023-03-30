import UIKit

// MARK: - RKIconButton

public final class RKIconButton: UIButton {

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
        var config = UIButton.Configuration.tinted()
        config.baseBackgroundColor = RKAssets.Colors.neutral5.color
        config.baseForegroundColor = RKAssets.Colors.neutral1.color
        config.cornerStyle = .capsule

        config.image = image?.withConfiguration(UIImage.SymbolConfiguration(scale: .medium))
        config.imagePlacement = .leading
        config.imagePadding = 8.0

        configuration = config
    }

}
