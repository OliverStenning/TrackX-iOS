import UIKit

// MARK: - RKTagView

public final class RKTagView: UIView {

    // MARK: Lifecycle

    public init() {
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public

    public var text: String = "" {
        didSet {
            label.text = text
        }
    }

    public var textColor: UIColor = RKAssets.Colors.neutral1.color.lightOnly {
        didSet {
            label.textColor = textColor
        }
    }

    public var font: UIFont = RKFonts.Archivo.semiBold.font(size: 16) {
        didSet {
            label.font = font
        }
    }

    // MARK: Private

    private let label = UILabel()

    private func setup() {
        layer.cornerRadius = 8
        label.text = text
        label.textColor = textColor
        label.font = font
        label.textAlignment = .center
        layout()
    }

    private func layout() {
        addSubview(label)
        label.pin(edges: .all, to: self, insets: .symmetrical(horizontal: 20, vertical: 5))
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
}
