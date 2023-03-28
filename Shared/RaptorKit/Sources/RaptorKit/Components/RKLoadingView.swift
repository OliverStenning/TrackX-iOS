import UIKit

// MARK: - RKLoadingView

public final class RKLoadingView: UIView {
    
    // MARK: - Lifecycle
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    
    private func setup() {
        layout()
        backgroundColor = RKAssets.Colors.background1.color
        loadingIndicator.color = RKAssets.Colors.accent3.color
        loadingIndicator.tintColor = RKAssets.Colors.accent3.color
        loadingIndicator.startAnimating()
    }
    
    private func layout() {
        addSubview(loadingIndicator)
        loadingIndicator.center(.horizontal, to: self)
        loadingIndicator.center(.vertical, to: self)
    }
    
}
