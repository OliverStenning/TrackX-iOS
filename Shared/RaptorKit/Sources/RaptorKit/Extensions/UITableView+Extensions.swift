import UIKit

// MARK: - ReusableView

public protocol ReusableView {
    static var reuseIdentifier: String { get }
}

public extension ReusableView {
    
    static var reuseIdentifier: String {
        String(describing: self)
    }
    
}

// MARK: - UITableViewCell + ReusableView

extension UITableViewCell: ReusableView {}

// MARK: - UITableViewHeaderFooterView + ReusableView

extension UITableViewHeaderFooterView: ReusableView {}

public extension UITableView {
    
    func register(_ cellClass: (some UITableViewCell).Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
    }
    
    func register(_ viewClass: (some UITableViewHeaderFooterView).Type) {
        register(viewClass, forHeaderFooterViewReuseIdentifier: viewClass.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue cell for \(T.reuseIdentifier) at \(indexPath)")
        }
        return cell
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Unable to dequeue view for \(T.reuseIdentifier)")
        }
        return view
    }
    
}
