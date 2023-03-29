import UIKit

// MARK: - RKLabel

public final class RKLabel: UILabel {

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

    public var fontStyle: RKFontStyle = .body {
        didSet {
            font = fontStyle.uiFont
        }
    }

    // MARK: Private

    private func setup() {
        numberOfLines = 0
        textColor = RKAssets.Colors.neutral1.color
        font = fontStyle.uiFont
    }

}
