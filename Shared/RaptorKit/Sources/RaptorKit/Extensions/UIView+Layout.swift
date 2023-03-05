import UIKit

// MARK: - EdgeSet

public struct EdgeSet: OptionSet {
    
    // MARK: - Lifecycle
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    // MARK: - Public
    
    public static let top = EdgeSet(rawValue: 1 << 0)
    public static let bottom = EdgeSet(rawValue: 1 << 1)
    public static let leading = EdgeSet(rawValue: 1 << 2)
    public static let trailing = EdgeSet(rawValue: 1 << 3)
    
    public static let topAndBottom: EdgeSet = [top, bottom]
    public static let leadingAndTrailing: EdgeSet = [leading, trailing]
    
    public static let all: EdgeSet = [top, bottom, leading, trailing]
    
    public let rawValue: Int
    
}

// MARK: - Edge

public enum Edge {
    
    case top, bottom, leading, trailing
    
    // MARK: - Internal
    
    var attribute: NSLayoutConstraint.Attribute {
        switch self {
        case .top: return .top
        case .bottom: return .bottom
        case .leading: return .leading
        case .trailing: return .trailing
        }
    }
    
}

// MARK: - Axis

public enum Axis {
    
    case horizontal, vertical
    
    // MARK: - Internal
    
    var centerAttribute: NSLayoutConstraint.Attribute {
        switch self {
        case .horizontal: return .centerX
        case .vertical: return .centerY
        }
    }
}

// MARK: - SizeDimension {

public enum SizeDimension {
    
    case width, height
    
    // MARK: - Internal
    
    var sizeAttribute: NSLayoutConstraint.Attribute {
        switch self {
        case .width: return .width
        case .height: return .height
        }
    }
    
}

public extension UIView {
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
    
    func addSubview(_ subview: UIView, insets: UIEdgeInsets = .zero, relation: NSLayoutConstraint.Relation = .equal, safeAreaEdges: EdgeSet = []) {
        addSubview(subview)
        subview.pin(edges: .all, to: self, insets: insets, relation: relation, safeAreaEdges: safeAreaEdges)
    }
    
    @discardableResult
    func pin(edges: EdgeSet, to otherView: UIView, insets: UIEdgeInsets = .zero, relation: NSLayoutConstraint.Relation = .equal, safeAreaEdges: EdgeSet = []) -> UIView {
        if edges.contains(.top) {
            pin(.top, to: .top, of: otherView, constant: insets.top, relation: relation, usingSafeArea: safeAreaEdges.contains(.top))
        }
        
        if edges.contains(.bottom) {
            pin(.bottom, to: .bottom, of: otherView, constant: insets.bottom, relation: relation, usingSafeArea: safeAreaEdges.contains(.bottom))
        }
        
        if edges.contains(.leading) {
            pin(.leading, to: .leading, of: otherView, constant: insets.left, relation: relation, usingSafeArea: safeAreaEdges.contains(.leading))
        }
        
        if edges.contains(.trailing) {
            pin(.trailing, to: .trailing, of: otherView, constant: insets.right, relation: relation, usingSafeArea: safeAreaEdges.contains(.trailing))
        }
        return self
    }
    
    @discardableResult
    func pin(_ edge: Edge, to otherViewEdge: Edge, of otherView: UIView, constant: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required, usingSafeArea: Bool = false) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        let negativeEdges: [Edge] = [.trailing, .bottom]
        let constant: CGFloat = (negativeEdges.contains(edge) || negativeEdges.contains(otherViewEdge)) ? -1 * constant : constant
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: edge.attribute,
            relatedBy: relation,
            toItem: usingSafeArea ? otherView.safeAreaLayoutGuide : otherView,
            attribute: otherViewEdge.attribute,
            multiplier: 1,
            constant: constant
        )
        constraint.isActive = true
        constraint.priority = priority
        return self
    }
 
    @discardableResult
    func size(_ sizeDimension: SizeDimension, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat, priority: UILayoutPriority = .required) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: sizeDimension.sizeAttribute,
            relatedBy: relation,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: constant
        )
        constraint.isActive = true
        constraint.priority = priority
        return self
    }
    
    @discardableResult
    func size(_ size: CGSize, priority: UILayoutPriority = .required) -> UIView {
        self.size(.width, relation: .equal, constant: size.width, priority: priority)
        self.size(.height, relation: .equal, constant: size.height, priority: priority)
        return self
    }

    @discardableResult
    func size(_ sizeDimension: SizeDimension, to otherViewSizeDimension: SizeDimension, of view: UIView, multiplier: CGFloat = 1, constant: CGFloat = 0) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        let constaint = NSLayoutConstraint(
            item: self,
            attribute: sizeDimension.sizeAttribute,
            relatedBy: .equal,
            toItem: view,
            attribute: otherViewSizeDimension.sizeAttribute,
            multiplier: multiplier,
            constant: constant
        )
        constaint.isActive = true
        return self
    }
    
}

public extension CGSize {
    
    static func square(_ constant: CGFloat) -> CGSize {
        CGSize(width: constant, height: constant)
    }
    
}


public extension UIEdgeInsets {
    
    static func all(_ constant: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: constant, left: constant, bottom: constant, right: constant)
    }
    
    static func symmetrical(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> UIEdgeInsets {
        UIEdgeInsets(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
    
    static func only(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> UIEdgeInsets {
        UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
    
}

public extension NSDirectionalEdgeInsets {
    
    static func all(_ constant: CGFloat) -> NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(top: constant, leading: constant, bottom: constant, trailing: constant)
    }
    
    static func symmetrical(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
    
    static func only(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
    
}

public extension UILayoutPriority {
    static var highestNotRequired: UILayoutPriority {
        UILayoutPriority(999)
    }
}
