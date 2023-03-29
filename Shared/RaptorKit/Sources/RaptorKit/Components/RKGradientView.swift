import UIKit

// MARK: - RKGradientView

public class RKGradientView: UIView {
    public override class var layerClass: AnyClass {
        CAGradientLayer.self
    }

    public var topColor: UIColor = .clear
    public var bottomColor: UIColor = RKAssets.Colors.background1.color
    public var locations: [NSNumber] = [0.0, 1.0]

    public override func layoutSubviews() {
        if let layer = layer as? CAGradientLayer {
            layer.colors = [topColor.cgColor, bottomColor.cgColor]
            layer.locations = locations
        }
    }
}
