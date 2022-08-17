//
//  UIView+Animations.swift
//  TrackX
//
//  Created by Oliver Stenning on 17/08/2022.
//

import UIKit

extension UIView {
    func springAnimate() {
        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                self.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
            },
            completion: { _ in
                UIView.animate(
                    withDuration: 0.1,
                    delay: 0,
                    options: .curveEaseInOut,
                    animations: {
                        self.transform = CGAffineTransform.identity
                    },
                    completion: nil
                )
            }
            )
    }
}
