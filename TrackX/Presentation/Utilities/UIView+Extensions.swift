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
    
    func pinBelow(_ superView: UIView, padding: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.bottomAnchor, constant: padding).isActive = true
    }
    
    func pinToSides(of superView: UIView, padding: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: padding).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: (-1 * padding)).isActive = true
    }
    
    func anchorSize(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func anchor(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
    }
    
    func anchor(to anchorView: UIView, padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: anchorView.topAnchor, constant: padding.top).isActive = true
        leadingAnchor.constraint(equalTo: anchorView.leadingAnchor, constant: padding.left).isActive = true
        bottomAnchor.constraint(equalTo: anchorView.bottomAnchor, constant: -padding.bottom).isActive = true
        trailingAnchor.constraint(equalTo: anchorView.trailingAnchor, constant: -padding.right).isActive = true
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
//    var bottomColor: UIColor = UIColor(named: "Background") ?? UIColor.clear
    var bottomColor: UIColor = UIColor.black
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = [topColor.cgColor, bottomColor.cgColor]
        (layer as! CAGradientLayer).locations = [0.0, 1.0]
    }
}
