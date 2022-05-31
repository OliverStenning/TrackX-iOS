//
//  LaunchDetailViewController.swift
//  TrackX
//
//  Created by Oliver Stenning on 29/05/2022.
//

import UIKit

class LaunchDetailViewController: UIViewController {
    
    // UI
    let mainImage: UIImageView = {
        let image = UIImageView()
        if let url = URL(string: "https://live.staticflickr.com/65535/49635401403_96f9c322dc_o.jpg") {
            image.load(url: url)
        }
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let launchNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Data
    var launch: Launch?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        
        view.addSubview(mainImage)
        view.addSubview(launchNameLabel)
        
        setupLayout()
        
        launchNameLabel.text = launch?.name ?? "Missing"
    }
    
    func setupLayout() {
        mainImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainImage.heightAnchor.constraint(equalTo: mainImage.widthAnchor, multiplier: 0.75).isActive = true
        
        launchNameLabel.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 12).isActive = true
        launchNameLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        launchNameLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
        
    }
     

    
}
