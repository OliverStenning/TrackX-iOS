//
//  LaunchSectionStackView.swift
//  TrackX
//
//  Created by Oliver Stenning on 13/06/2022.
//

import UIKit

class LaunchSectionStackView: UIStackView {
    
    //MARK: - Views
    private let nameLabel = AccentHeadingView()
    
    private let dateStatusStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.fill
        stackView.alignment = .center
        stackView.spacing = 16
        return stackView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "ArchivoRoman-Medium", size: 18)
        label.textColor = UIColor(named: "SecondaryTextColor")
        return label
    }()
    
    private let statusView = StatusView()
    
    private let spacerView: UIView = {
        let view = UIView()
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return view
    }()
    
    private let descriptionLabel = BodyLabel()
    
    //MARK: - Properties
    var launch: Launch? = nil {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Functions
    private func setupViews() {
        axis = .vertical
        distribution = .fill
        spacing = 8
        
        addArrangedSubview(nameLabel)
        addArrangedSubview(dateStatusStack)
        addArrangedSubview(descriptionLabel)
        
        dateStatusStack.addArrangedSubview(dateLabel)
        dateStatusStack.addArrangedSubview(statusView)
        dateStatusStack.addArrangedSubview(spacerView)
        
    }
    
    private func setupConstraints() {
        statusView.anchorYCenter(to: dateLabel)
        
        setCustomSpacing(16, after: dateStatusStack)
        setCustomSpacing(16, after: descriptionLabel)
    }
    
    //MARK: - Update Functions
    private func updateViews() {
        nameLabel.text = launch?.name ?? "Missing"
        dateLabel.text = formatDate(from: launch?.dateUtc ?? "")
        
        if let description = launch?.details {
            descriptionLabel.isHidden = false
            descriptionLabel.text = description
        } else {
            descriptionLabel.isHidden = true
            descriptionLabel.text = ""
        }
        
        if launch?.upcoming ?? false {
            statusView.setStatus(.scheduled)
        } else if launch?.success ?? false {
            statusView.setStatus(.success)
        } else {
            statusView.setStatus(.failed)
        }
    }
    
}
