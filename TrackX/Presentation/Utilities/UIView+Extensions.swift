//
//  UIView+Extensions.swift
//  TrackX
//
//  Created by Oliver Stenning on 25/03/2022.
//

import UIKit

extension UIView {
    
    func pin(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    }
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension UIView {
    func addGradient(startColor: CGColor, endColor: CGColor, frame: CGRect) {
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.colors = [startColor, endColor]
        gradient.borderWidth = 5
        gradient.borderColor = UIColor.red.cgColor
        //gradient.locations = [0.0, 1.0]
        self.layer.insertSublayer(gradient, at: 0)
    }
}

class GradientView: UIView {
    var topColor: UIColor = UIColor.clear
    var bottomColor: UIColor = UIColor(named: "Background") ?? UIColor.clear
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = [topColor.cgColor, bottomColor.cgColor]
        (layer as! CAGradientLayer).locations = [0.0, 1.0]
    }
}
