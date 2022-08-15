//
//  CountdownNumberView.swift
//  TrackX
//
//  Created by Oliver Stenning on 13/08/2022.
//

import UIKit

class CountdownNumberView: UIView {
    
    //MARK: - Views
    let numberLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.latoBold(size: 24)
        label.textColor = R.color.textColor()
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - Properties
    
    //MARK: - Initializers
    init(number: String = "-") {
        super.init(frame: .zero)
        
        numberLabel.text = number
        configureViews()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration Functions
    private func configureViews() {
        backgroundColor = R.color.backgroundColor()
        layer.cornerRadius = 8
        
        addSubview(numberLabel)
    }
    
    private func configureConstraints() {
        let padding: CGFloat = 6
        
        numberLabel.anchor(
            to: self,
            padding: .init(
                top: padding / 2,
                left: padding,
                bottom: padding / 2,
                right: padding
            )
        )
        
        numberLabel.anchorSize(height: 30,width: 14)
    }
}
