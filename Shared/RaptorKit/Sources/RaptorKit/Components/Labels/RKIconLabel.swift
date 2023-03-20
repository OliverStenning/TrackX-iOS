import UIKit

// MARK: - RKIconLabel

final public class RKIconLabel: UIView {
    
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
    
    public let icon = UIImageView()
    public let label = UILabel()
    
    // MARK: - Private
    
    private func setup() {
        setupIcon()
        setupLabel()
        layout()
    }
    
    private func setupIcon() {
        icon.tintColor = .secondaryLabel
    }
    
    private func setupLabel() {
        label.font = RKFonts.Archivo.regular.font(size: 18)
        label.textColor = .secondaryLabel
    }
    
    private func layout() {
        addSubviews(icon, label)
        
        icon.pin(edges: [.topAndBottom, .leading], to: self)
        icon.size(.square(20))
        
        label.pin(.leading, to: .trailing, of: icon, constant: -8)
        label.pin(edges: [.topAndBottom, .trailing], to: self)
    }
    
}
