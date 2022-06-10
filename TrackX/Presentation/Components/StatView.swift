//
//  StatView.swift
//  TrackX
//
//  Created by Oliver Stenning on 08/06/2022.
//

import UIKit

final class StatView: UIView {
    
    let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .secondaryLabel
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let textStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let name: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let value1: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let value2: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(icon: String, name: String) {
        super.init(frame: .zero)
        
        self.icon.image = UIImage(systemName: icon)
        self.name.text = name
        setupView()
    }
    
    private func setupView() {
        addViews()
        setupLayout()
    }
    
    private func addViews() {
        addSubview(icon)
        addSubview(textStack)
        textStack.addArrangedSubview(name)
        textStack.addArrangedSubview(value1)
        textStack.addArrangedSubview(value2)
    }
    
    private func setupLayout() {
        icon.anchor(leading: leadingAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 0), size: .init(width: 20, height: 20))
        icon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        textStack.anchor(top: topAnchor, leading: icon.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 8))
        
    }
    
}
