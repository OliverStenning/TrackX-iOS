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
    
    private let alternateLabel: UILabel = {
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
    var alternate: String? = nil {
        didSet {
            if let alternateString = alternate {
                alternateLabel.text = alternateString
                alternateLabel.isHidden = false
            } else {
                alternateLabel.isHidden = true
            }
        }
    }
    var expanded: Bool = false {
        didSet {
            valueLabel.numberOfLines = expanded ? 0 : lineCount
            alternateLabel.numberOfLines = expanded ? 0 : lineCount
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
        configureViews()
        configureConstraints()
    }
    
    //MARK: - Configuration Functions
    private func configureViews() {
        addSubview(infoStack)
        infoStack.addArrangedSubview(nameLabel)
        infoStack.addArrangedSubview(valueLabel)
        infoStack.addArrangedSubview(alternateLabel)
        
        valueLabel.numberOfLines = lineCount
        alternateLabel.numberOfLines = lineCount
        
        self.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapBody))
        gesture.numberOfTapsRequired = 1
        addGestureRecognizer(gesture)
        addGestureRecognizer(gesture)
    }
    
    private func configureConstraints() {
        infoStack.anchor(to: self)
    }
    
    //MARK: - Update Functions
    @objc func tapBody() {
        expanded.toggle()
    }
}
