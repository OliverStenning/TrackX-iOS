//
//  GradientView.swift
//  TrackX
//
//  Created by Oliver Stenning on 12/06/2022.
//

import RaptorKit
import UIKit

class GradientView: UIView {
    var topColor: UIColor = UIColor.clear
    var bottomColor: UIColor = RKAssets.Colors.secondaryBackgroundColor.color
    var locations: [NSNumber] = [0.0, 1.0]
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = [topColor.cgColor, bottomColor.cgColor]
        (layer as! CAGradientLayer).locations = locations
    }
}
