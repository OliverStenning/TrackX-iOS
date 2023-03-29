import UIKit

// MARK: - RKCapsuleLabel

public final class RKCapsuleLabel: UIView {

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

    public let label = UILabel()

    // MARK: Private

    private let capsule = UIView()
    private var capsuleWidthConstraint: NSLayoutConstraint?
    private var capsuleWidth: CGFloat = 8.0

    private func setup() {
        setupCapsule()
        setupLabel()
        layout()
    }

    private func setupCapsule() {
        capsule.backgroundColor = RKAssets.Colors.accent3.color
    }

    private func setupLabel() {
        label.textColor = RKAssets.Colors.neutral1.color
        label.font = RKFonts.Archivo.medium.font(size: 24)
    }

    private func updateCapsuleSize() {
        capsule.translatesAutoresizingMaskIntoConstraints = false
        if let capsuleWidthConstraint {
            capsuleWidthConstraint.constant = capsuleWidth
        } else {
            capsuleWidthConstraint = capsule.widthAnchor.constraint(equalToConstant: capsuleWidth)
            capsuleWidthConstraint?.isActive = true
        }

        capsule.layer.cornerRadius = capsuleWidth / 2
    }

    private func layout() {
        addSubviews(capsule, label)

        capsule.pin(edges: [.topAndBottom, .leading], to: self)

        label.pin(.leading, to: .trailing, of: capsule, constant: -8)
        label.pin(edges: [.topAndBottom, .trailing], to: self)

        updateCapsuleSize()
    }
}
