//
//  LaunchTablePrimaryCell.swift
//  TrackX
//
//  Created by Oliver Stenning on 09/06/2022.
//

import UIKit

class LaunchTablePrimaryCell: LaunchTableCell {
    
    //MARK: - Views
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let backgroundGradient: UIView = {
        let view = GradientView()
        view.bottomColor = UIColor(named: "SecondaryBackgroundColor") ?? .black
        view.locations = [-1.0, 1.0]
        return view
    }()
    
    private let nameView = LaunchCellNameView()
    private let infoView = LaunchCellInfoView()
    
    //MARK: - Properties
    private var fullLaunch: FullLaunch? = nil
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstaints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Functions
    func setFullLaunch(_ fullLaunch: FullLaunch?) {
        self.fullLaunch = fullLaunch
        nameView.setFullLaunch(fullLaunch)
        infoView.setFullLaunch(fullLaunch)
        updateViews()
    }
    
    func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        container.addSubview(backgroundImage)
        container.addSubview(backgroundGradient)
        container.addSubview(nameView)
        container.addSubview(infoView)
    }
    
    func setupConstaints() {

        container.anchorSize(height: 200)
        
        backgroundImage.anchor(to: container)
        
        backgroundGradient.anchor(to: container)
        
        nameView.anchor(
            top: container.topAnchor,
            leading: container.leadingAnchor,
            trailing: container.trailingAnchor
        )
        
        infoView.anchor(
            leading: container.leadingAnchor,
            bottom: container.bottomAnchor,
            trailing: container.trailingAnchor
        )
        
    }
    
    //MARK: - Update Functions
    func updateViews() {
        guard let imageUrls = fullLaunch?.launch.links?.flickr?.original else { return }
        if !imageUrls.isEmpty {
            backgroundImage.downloaded(from: imageUrls[0])
        } else {
            backgroundImage.image = UIImage(named: "placeholder_image")
            backgroundImage.downloaded(from: "https://live.staticflickr.com/65535/51676939646_1a12780e54_o.jpg")
        }
    }
    
}
