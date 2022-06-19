//
//  LaunchTableCell.swift
//  TrackX
//
//  Created by Oliver Stenning on 19/06/2022.
//

import UIKit

class LaunchTableCell: UITableViewCell {
    
    //MARK: - Views
    let container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContainer()
        setupContainerConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContainer() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(container)
    }
    
    func setupContainerConstraints() {
        container.anchor(
            to: contentView,
            padding: .init(top: 8, left: 16, bottom: 8, right: 16)
        )
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            UIView.animate(
                withDuration: 0.2,
                delay: 0,
                options: .curveEaseInOut,
                animations: {
                    self.container.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                },
                completion: nil
            )
        } else {
            UIView.animate(
                withDuration: 0.2,
                delay: 0,
                options: .curveEaseInOut,
                animations: {
                    self.container.transform = CGAffineTransform.identity
                },
                completion: nil
            )
        }
    }
    
}
