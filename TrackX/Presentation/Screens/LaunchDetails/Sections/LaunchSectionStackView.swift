//
//  LaunchSectionStackView.swift
//  TrackX
//
//  Created by Oliver Stenning on 13/06/2022.
//

import UIKit

class LaunchSectionStackView: UIStackView {
    
    //MARK: - Views
    private let nameLabel = AccentHeadingView(size: .h1)
    
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
//        label.font = R.font.archivoMedium(size: 18)
//        label.textColor = R.color.secondaryTextColor()
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
        configureViews()
        configureConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration Functions
    private func configureViews() {
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
    
    private func configureConstraints() {
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
            statusView.status = .scheduled
        } else if launch?.success ?? false {
            statusView.status = .success
        } else {
            statusView.status = .failed
        }
    }
    
}
