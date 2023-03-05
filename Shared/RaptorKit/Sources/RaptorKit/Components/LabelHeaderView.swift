import UIKit

// MARK: - LabelHeaderView

public final class LabelHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Lifecycle
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    
    public func configure(with title: String) {
        titleLabel.text = title
    }
    
    // MARK: - Private
    
    private let titleLabel = UILabel()
    
    private func setup() {
        contentView.addSubview(titleLabel)
        titleLabel.pin(edges: .all, to: contentView)
    }
    
}
