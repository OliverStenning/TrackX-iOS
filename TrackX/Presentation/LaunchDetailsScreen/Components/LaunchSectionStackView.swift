//
//  LaunchSectionStackView.swift
//  TrackX
//
//  Created by Oliver Stenning on 13/06/2022.
//

import UIKit

class LaunchSectionStackView: UIStackView {
    
    //MARK: - Views
    private let nameLabel = HeadingLabel()
    
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
    
    private let statusView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 14
        return view
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Archivo-SemiBold", size: 16)
        label.textColor = UIColor(named: "BackgroundColor")
        return label
    }()
    
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
    
    convenience init(launch: Launch?) {
        self.init(frame: .zero)
        self.launch = launch
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
        
        statusView.addSubview(statusLabel)
    }
    
    private func setupConstraints() {
        statusView.anchorSize(height: 28)
        statusView.anchorYCenter(to: dateLabel)
        
        statusLabel.anchor(
            top: statusView.topAnchor,
            leading: statusView.leadingAnchor,
            bottom: statusView.bottomAnchor,
            trailing: statusView.trailingAnchor,
            padding: .init(top: 0, left: 16, bottom: 0, right: 16)
        )
        
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
            statusView.backgroundColor = UIColor(named: "AccentColor")
            statusLabel.text = "Scheduled"
            statusLabel.textColor = UIColor(named: "BackgroundColor")
        } else if launch?.success ?? false {
            statusView.backgroundColor = .systemGreen
            statusLabel.text = "Success"
            statusLabel.textColor = UIColor(named: "BackgroundColor")
        } else {
            statusView.backgroundColor = .systemRed
            statusLabel.text = "Failed"
            statusLabel.textColor = UIColor(named: "BackgroundColor")
        }
    }
    
}
