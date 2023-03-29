import UIKit

public final class RKNamedLabel: UIView {
    // MARK: - Lifecycle

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init(name: String = "", lineCount: Int = 3) {
        self.name = name
        self.lineCount = lineCount
        super.init(frame: .zero)
        setup()
    }

    // MARK: - Public

    public var name: String {
        didSet {
            nameLabel.text = name
        }
    }

    public var value: String = "" {
        didSet {
            valueLabel.text = value
        }
    }

    public var expanded: Bool = false {
        didSet {
            valueLabel.numberOfLines = expanded ? 0 : lineCount
        }
    }

    // MARK: - Private

    private let lineCount: Int
    private let containerStack = UIStackView()
    private let nameLabel = UILabel()
    private let valueLabel = UILabel()

    private func setup() {
        setupStackView()
        setupLabels()
        setupNumberOfLinesGesture()
        layout()
    }

    private func setupStackView() {
        containerStack.axis = NSLayoutConstraint.Axis.vertical
        containerStack.distribution = UIStackView.Distribution.fill
    }

    private func setupLabels() {
        nameLabel.text = name
        nameLabel.font = RKFonts.Rubik.medium.font(size: 15)
        nameLabel.textColor = RKAssets.Colors.neutral5.color

        valueLabel.numberOfLines = lineCount
        valueLabel.font = RKFonts.Rubik.regular.font(size: 15)
        valueLabel.textColor = RKAssets.Colors.neutral1.color
    }

    private func setupNumberOfLinesGesture() {
        isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapBody))
        addGestureRecognizer(gesture)
    }

    private func layout() {
        addSubview(containerStack)
        containerStack.pin(edges: .all, to: self)

        containerStack.addArrangedSubview(nameLabel)
        containerStack.addArrangedSubview(valueLabel)
    }

    @objc private func tapBody() {
        expanded.toggle()
    }
}
