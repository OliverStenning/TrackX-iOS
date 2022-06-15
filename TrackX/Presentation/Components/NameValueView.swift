//
//  NameValueView.swift
//  TrackX
//
//  Created by Oliver Stenning on 07/06/2022.
//

import UIKit

final class NameValueView: UIView {
    
    //MARK: - Views 
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
        return label
    }()
    
    private let value2Label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "RubikRoman-Regular", size: 15)
        label.textColor = UIColor(named: "TextColor")
        label.isHidden = true
        return label
    }()
    
    //MARK: - Properties
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
    var expanded: Bool = false {
        didSet {
            valueLabel.numberOfLines = expanded ? 0 : lineCount
            value2Label.numberOfLines = expanded ? 0 : lineCount
        }
    }
    let lineCount: Int
    
    //MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(name: String, lineCount: Int = 3) {
        self.name = name
        self.lineCount = lineCount
        nameLabel.text = name
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    //MARK: - Setup Functions
    private func setupViews() {
        addSubview(infoStack)
        infoStack.addArrangedSubview(nameLabel)
        infoStack.addArrangedSubview(valueLabel)
        infoStack.addArrangedSubview(value2Label)
        
        valueLabel.numberOfLines = lineCount
        value2Label.numberOfLines = lineCount
        
        self.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapBody))
        gesture.numberOfTapsRequired = 1
        addGestureRecognizer(gesture)
        addGestureRecognizer(gesture)
    }
    
    private func setupConstraints() {
        infoStack.anchor(to: self)
    }
    
    //MARK: - Update Functions
    @objc func tapBody() {
        expanded.toggle()
    }
}
