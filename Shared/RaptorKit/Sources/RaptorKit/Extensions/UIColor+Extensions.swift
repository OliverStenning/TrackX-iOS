import UIKit

public extension UIColor {
    
    var darkOnly: UIColor {
        resolvedColor(with: .init(userInterfaceStyle: .dark))
    }
    
    var lightOnly: UIColor {
        resolvedColor(with: .init(userInterfaceStyle: .light))
    }
    
}
