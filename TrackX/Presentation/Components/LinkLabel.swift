//
//  LinkLabel.swift
//  TrackX
//
//  Created by Oliver Stenning on 11/07/2022.
//

import RaptorKit
import UIKit

class LinkLabel: UILabel {
    
    var url: String
    
    init(text: String = "", url: String = "") {
        self.url = url
        super.init(frame: .zero)
        self.text = text
        self.textColor = RKAssets.Colors.accent.color
        self.font = RKFonts.Archivo.semiBold.font(size: 16)
        self.numberOfLines = 0
        self.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapLink))
        gesture.numberOfTapsRequired = 1
        addGestureRecognizer(gesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with url: String) {
        self.url = url
    }
    
    @objc func tapLink() {
        if let url = URL(string: url) {
            UIApplication.shared.open(url)
        }
    }
    
}
