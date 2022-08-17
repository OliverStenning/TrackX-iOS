//
//  PhotoCollectionCell.swift
//  TrackX
//
//  Created by Oliver Stenning on 15/08/2022.
//

import UIKit
import Combine

class PhotoCollectionCell: UICollectionViewCell {
    
    //MARK: - Views
    private let photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: - Properties
    private var photo: UIImage? {
        didSet {
            updateViews()
        }
    }
    
    private var cancellable: AnyCancellable?
    private var animator: UIViewPropertyAnimator?
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        configureViews()
        configureConstaints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration Functions
    private func addViews() {
        contentView.addSubview(photoView)
    }
    
    func configure(with photo: UIImage?) {
        self.photo = photo
    }
    
    private func configureViews() {
        photoView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(pressPhoto))
        gesture.numberOfTapsRequired = 1
        photoView.addGestureRecognizer(gesture)
        
        photoView.layer.cornerRadius = 16
        photoView.layer.masksToBounds = true
    }
    
    private func configureConstaints() {
        photoView.anchor(to: contentView, padding: .init(top: 0, left: 0, bottom: 0, right: 12))
    }
    
    //MARK: - Update Functions
    private func updateViews() {
        photoView.image = photo
    }
    
    //MARK: - Interaction Functions
    @objc private func pressPhoto() {
        photoView.springAnimate()
    }
}
