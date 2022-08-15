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
        label.font = R.font.archivoSemiBold(size: 14)
        label.textColor = R.color.backgroundColor()
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - Properties
    var status: StatusType = .success {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        configureViews()
        configureConstraints()
    }
    
    //MARK: - Configuration Functions
    private func configureViews() {
        addSubview(statusLabel)
        backgroundColor = .systemGreen
        layer.cornerRadius = 6
    }
    
    private func configureConstraints() {
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
                statusLabel.textColor = R.color.backgroundColor()
            case .failed:
                backgroundColor = .systemRed
                statusLabel.text = "Failed"
                statusLabel.textColor = R.color.backgroundColor()
            case .scheduled:
                backgroundColor = R.color.accentColor()
                statusLabel.text = "Scheduled"
                statusLabel.textColor = R.color.backgroundColor()
                
        }
    }
    
}
