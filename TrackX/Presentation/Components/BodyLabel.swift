//
//  BodyLabel.swift
//  TrackX
//
//  Created by Oliver Stenning on 13/06/2022.
//

import UIKit

class BodyLabel: UILabel {
    
    var name: String {
        didSet {
            self.text = name
        }
    }
    var expanded: Bool = false {
        didSet {
            self.numberOfLines = expanded ? 0 : lineCount
        }
    }
    var bold: Bool {
        didSet {
            if bold {
                font = UIFont(name: "RubikRoman-Medium", size: 15)
            } else {
                font = UIFont(name: "RubikRoman-Regular", size: 15)
            }
        }
    }
    let lineCount: Int
    
    init(text: String = "", lineCount: Int = 4, bold: Bool = false) {
        self.name = text
        self.lineCount = lineCount
        self.bold = false
        super.init(frame: .zero)
        
        self.text = text
        
        textColor = UIColor(named: "TextColor")
        numberOfLines = lineCount
        isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapBody))
        gesture.numberOfTapsRequired = 1
        addGestureRecognizer(gesture)
        
        defer {
            self.bold = bold
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapBody() {
        expanded.toggle()
    }
    
}
