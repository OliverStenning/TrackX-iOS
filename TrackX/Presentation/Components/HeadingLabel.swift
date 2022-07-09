//
//  HeadingLabel.swift
//  TrackX
//
//  Created by Oliver Stenning on 13/06/2022.
//

import UIKit

public enum HeadingSize {
    case h1
    case h2
    case h3
    case h4
    case h5
}

class HeadingLabel: UILabel {
    
    init(text: String = "", size: HeadingSize) {
        super.init(frame: .zero)
        self.text = text
        self.textColor = UIColor(named: "TextColor")
        self.font = UIFont(name: "Archivo-SemiBold", size: getFontSize(size: size))
        self.numberOfLines = 0
        self.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getFontSize(size: HeadingSize) -> CGFloat {
        switch(size) {
            case .h1:
                return 30
            case .h2:
                return 24
            case .h3:
                return 22
            case .h4:
                return 18
            case .h5:
                return 16
        }
    }
    
}
