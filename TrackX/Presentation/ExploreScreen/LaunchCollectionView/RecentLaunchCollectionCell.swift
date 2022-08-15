//
//  RecentLaunchCollectionCell.swift
//  TrackX
//
//  Created by Oliver Stenning on 14/08/2022.
//

import UIKit
import Combine

class RecentLaunchCollectionCell: UICollectionViewCell {
    
    //MARK: - Views
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let backgroundGradient: UIView = {
        let view = GradientView()
        view.bottomColor = R.color.secondaryBackgroundColor() ?? .black
        view.locations = [-1.0, 1.0]
        return view
    }()
    
    private let nameLabel = AccentHeadingView(size: .h3, capsuleSize: 6)
    private let statusView = StatusView()
    private let infoView = LaunchCellInfoView()
    
    //MARK: - Properties
    private var fullLaunch: FullLaunch? {
        didSet {
            updateViews()
        }
    }
    
    private var cancellable: AnyCancellable?
    private var animator: UIViewPropertyAnimator?
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureConstaints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle Functions
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundImage.image = nil
        backgroundImage.alpha = 0.0
        animator?.stopAnimation(true)
        cancellable?.cancel()
    }
    
    //MARK: - Configuration Functions
    func configure(with fullLaunch: FullLaunch?) {
        self.fullLaunch = fullLaunch
        infoView.configure(with: fullLaunch)
    }
    
    func configureViews() {
        contentView.backgroundColor = R.color.secondaryBackgroundColor()
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(backgroundImage)
        contentView.addSubview(backgroundGradient)
        contentView.addSubview(nameLabel)
        contentView.addSubview(statusView)
        contentView.addSubview(infoView)
    }
    
    func configureConstaints() {
        backgroundImage.anchor(to: contentView)
        backgroundGradient.anchor(to: contentView)
        
        nameLabel.anchor(
            leading: contentView.leadingAnchor,
            bottom: infoView.topAnchor,
            trailing: contentView.trailingAnchor,
            padding: .init(top: 0, left: 16, bottom: 0, right: 16)
        )
        
        statusView.anchor(
            top: contentView.topAnchor,
            trailing: contentView.trailingAnchor,
            padding: .init(top: 16, left: 0, bottom: 0, right: 16)
        )
        
        infoView.anchor(
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor
        )
    }
    
    //MARK: - Update Functions
    func updateViews() {
        if let fullLaunch = fullLaunch {
            nameLabel.text = fullLaunch.launch.name
            
            if let imageUrl = fullLaunch.getLaunchImageUrl() {
                cancellable = loadImage(for: imageUrl).sink { [unowned self] image in self.showImage(image: image)}
            } else {
                showImage(image: R.image.placeholderImage())
            }
            
            if fullLaunch.launch.upcoming {
                statusView.status = .scheduled
            } else if fullLaunch.launch.success ?? false {
                statusView.status = .success
            } else {
                statusView.status = .failed
            }
        }
    }
    
    func showImage(image: UIImage?) {
        backgroundImage.alpha = 0.0
        animator?.stopAnimation(false)
        backgroundImage.image = image
        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.backgroundImage.alpha = 1.0
        })
    }
    
    func loadImage(for url: String) -> AnyPublisher<UIImage?, Never> {
        return Just(url)
            .flatMap({ url -> AnyPublisher<UIImage?, Never> in
                let url = URL(string: url)!
                return ImageLoader.shared.loadImage(from: url)
            })
            .eraseToAnyPublisher()
    }
    
}
