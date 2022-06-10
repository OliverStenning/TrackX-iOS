//
//  NameValueView.swift
//  TrackX
//
//  Created by Oliver Stenning on 07/06/2022.
//

import UIKit

final class NameValueView: UIView {
    
    var nameText: String
    var valueText: String = ""
    
    let container: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(nameText: String) {
        self.nameText = nameText
        super.init(frame: .zero)
        setupView()
    }
    
    private func setupView() {
        nameLabel.text = nameText
        valueLabel.text = valueText
        
        addViews()
        setupLayout()
    }
    
    private func addViews() {
        addSubview(container)
        container.addSubview(nameLabel)
        container.addSubview(valueLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            valueLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}
