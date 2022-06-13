//
//  UIView+Extensions.swift
//  TrackX
//
//  Created by Oliver Stenning on 25/03/2022.
//

import UIKit

extension UIView {
    
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
    
    func anchorSize(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func anchorSize(height: CGFloat? = nil, width: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }

    func anchorHeight(to anchorView: UIView, multiplier: CGFloat = 1.0) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalTo: anchorView.heightAnchor, multiplier: multiplier).isActive = true
    }
    
    func anchorWidth(to anchorView: UIView, multiplier: CGFloat = 1.0) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: anchorView.widthAnchor, multiplier: multiplier).isActive = true
    }
    
    func anchorYCenter(to anchorView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: anchorView.centerYAnchor).isActive = true
    }
    
    func anchorXCenter(to anchorview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: anchorview.centerXAnchor).isActive = true
    }
    
    
}
