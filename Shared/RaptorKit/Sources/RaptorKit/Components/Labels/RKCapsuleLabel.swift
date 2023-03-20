import UIKit

// MARK: - RKCapsuleLabel

final public class RKCapsuleLabel: UIView {
    
    // MARK: - Lifecycle
    
    public init() {
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    
    public let label = UILabel()
    
    // MARK: - Private
    
    private let capsule = UIView()
    private var capsuleWidthConstraint: NSLayoutConstraint?
    private var capsuleWidth: CGFloat = 8.0
    
    private func setup() {
        setupCapsule()
        setupLabel()
        layout()
    }
    
    private func setupCapsule() {
        capsule.backgroundColor = RKAssets.Colors.accent.color
    }
    
    private func setupLabel() {
        label.font = RKFonts.Archivo.medium.font(size: 28)
        label.textColor = .label
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
