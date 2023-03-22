import UIKit

// MARK: - RKGradientView

public class RKGradientView: UIView {
    
    // MARK: - Public
    
    public var topColor: UIColor = UIColor.clear
    public var bottomColor: UIColor = RKAssets.Colors.background1.color
    public var locations: [NSNumber] = [0.0, 1.0]
    
    public override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    public override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = [topColor.cgColor, bottomColor.cgColor]
        (layer as! CAGradientLayer).locations = locations
    }
    
}
