//
//  SubheadingLabel.swift
//  TrackX
//
//  Created by Oliver Stenning on 13/06/2022.
//

import UIKit

class SubheadingLabel: UILabel {
    
    var name: String {
        didSet {
            self.text = name
        }
    }
    
    init(text: String = "") {
        self.name = text
        super.init(frame: .zero)
        self.text = text
        self.font = UIFont(name: "Archivo-SemiBold", size: 22)
        self.textColor = UIColor(named: "TextColor")
        self.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
