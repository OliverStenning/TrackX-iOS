//
//  StatusView.swift
//  TrackX
//
//  Created by Oliver Stenning on 18/06/2022.
//

import UIKit

enum StatusType {
    case success
    case failed
    case scheduled
}

class StatusView: UIView {
    
    //MARK: - Views
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Archivo-SemiBold", size: 14)
        label.textColor = UIColor(named: "BackgroundColor")
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - Properties
    private var status: StatusType = .success
    
    //MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    //MARK: - Setup Function
    func setStatus(_ status: StatusType) {
        self.status = status
        updateViews()
    }
    
    private func setupViews() {
        addSubview(statusLabel)
        backgroundColor = .systemGreen
        layer.cornerRadius = 6
    }
    
    private func setupConstraints() {
        statusLabel.anchor(
            to: self,
            padding: .init(top: 4, left: 16, bottom: 4, right: 16)
        )
        
        statusLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        statusLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
 
    //MARK: - Update Functions
    func updateViews() {
        switch status {
            case .success:
                backgroundColor = .systemGreen
                statusLabel.text = "Success"
                statusLabel.textColor = UIColor(named: "SecondaryBackgroundColor")
            case .failed:
                backgroundColor = .systemRed
                statusLabel.text = "Failed"
                statusLabel.textColor = UIColor(named: "SecondaryBackgroundColor")
            case .scheduled:
                backgroundColor = UIColor(named: "AccentColor")
                statusLabel.text = "Scheduled"
                statusLabel.textColor = UIColor(named: "SecondaryBackgroundColor")
                
        }
    }
    
}
