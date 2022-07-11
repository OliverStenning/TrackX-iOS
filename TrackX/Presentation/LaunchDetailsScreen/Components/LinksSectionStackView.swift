//
//  LinksSectionStackView.swift
//  TrackX
//
//  Created by Oliver Stenning on 11/07/2022.
//

import UIKit

class LinksSectionStackView: UIStackView {
    
    //MARK: - Views
    private let sectionLabel = HeadingLabel(text: "Links", size: .h2)
    private let webcastLinkLabel = LinkLabel(text: "Webcast")
    private let articleLinkLabel = LinkLabel(text: "Article")
    private let wikipediaLinkLabel = LinkLabel(text: "Wikipedia")
    private let presskitLinkLabel = LinkLabel(text: "Presskit")
    
    //MARK: - Properties
    
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
    func configureWith(links: Links) {
        if let webcast = links.webcast {
            webcastLinkLabel.configure(with: webcast)
            addArrangedSubview(webcastLinkLabel)
        }
        if let article = links.article {
            articleLinkLabel.configure(with: article)
            addArrangedSubview(articleLinkLabel)
        }
        if let wikipedia = links.wikipedia {
            wikipediaLinkLabel.configure(with: wikipedia)
            addArrangedSubview(wikipediaLinkLabel)
        }
        if let presskit = links.presskit {
            presskitLinkLabel.configure(with: presskit)
            addArrangedSubview(presskitLinkLabel)
        }
        
    }
    
    private func configureViews() {
        axis = .vertical
        distribution = .fill
        spacing = 16
        
        addArrangedSubview(sectionLabel)
    }
    
    private func configureConstraints() {

    }
    
    //MARK: - Update Functions
    private func updateViews() {

    }
    
}
