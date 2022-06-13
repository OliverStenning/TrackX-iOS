//
//  NameValueView.swift
//  TrackX
//
//  Created by Oliver Stenning on 07/06/2022.
//

import UIKit

final class NameValueView: UIView {
    
    private let infoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fill
        return stackView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "RubikRoman-Medium", size: 15)
        label.textColor = UIColor(named: "SecondaryTextColor")
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "RubikRoman-Regular", size: 15)
        label.textColor = UIColor(named: "TextColor")
        label.numberOfLines = 0
        return label
    }()
    
    private let value2Label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "RubikRoman-Regular", size: 15)
        label.textColor = UIColor(named: "TextColor")
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    var name: String = "" {
        didSet {
            nameLabel.text = name
        }
    }
    var value: String = "" {
        didSet {
            valueLabel.text = value
        }
    }
    var value2: String? = nil {
        didSet {
            if let value2String = value2 {
                value2Label.text = value2String
                value2Label.isHidden = false
            } else {
                value2Label.isHidden = true
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(name: String) {
        self.name = name
        nameLabel.text = name
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        addSubview(infoStack)
        infoStack.addArrangedSubview(nameLabel)
        infoStack.addArrangedSubview(valueLabel)
        infoStack.addArrangedSubview(value2Label)
    }
    
    private func setupConstraints() {
        infoStack.anchor(to: self)
    }
    
}
