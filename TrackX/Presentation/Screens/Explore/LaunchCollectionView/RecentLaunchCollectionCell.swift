//
//  RecentLaunchCollectionCell.swift
//  TrackX
//
//  Created by Oliver Stenning on 14/08/2022.
//

import RaptorKit
import UIKit
import Combine

class RecentLaunchCollectionCell: UICollectionViewCell {
    
    //MARK: - Views
    private let cardView = UIView()
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let backgroundGradient: UIView = {
        let view = GradientView()
        view.bottomColor = RKAssets.Colors.background2.color
        view.locations = [-1.0, 1.0]
        return view
    }()
    
    private let nameView = LaunchCellNameView()
    private let infoView = LaunchCellInfoView()
    
    //MARK: - Properties
    private var fullLaunch: FullLaunch? = nil
    
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
    
    //MARK: - Lifecycle Functions
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundImage.image = nil
        backgroundImage.alpha = 0.0
        animator?.stopAnimation(true)
        cancellable?.cancel()
    }
    
    //MARK: - Configuration Functions
    private func addViews() {
        contentView.addSubview(cardView)
        cardView.addSubview(backgroundImage)
        cardView.addSubview(backgroundGradient)
        cardView.addSubview(nameView)
        cardView.addSubview(infoView)
    }
    
    func configure(with fullLaunch: FullLaunch?) {
        self.fullLaunch = fullLaunch
        nameView.configure(with: fullLaunch)
        infoView.configure(with: fullLaunch)
        updateViews()
    }
    
    func configureViews() {
        isUserInteractionEnabled = true
        cardView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(pressLaunch))
        gesture.numberOfTapsRequired = 1
        gesture.cancelsTouchesInView = false
        cardView.addGestureRecognizer(gesture)
        
        cardView.backgroundColor = RKAssets.Colors.background2.color
        cardView.layer.cornerRadius = 16
        cardView.layer.masksToBounds = true
    }
    
    func configureConstaints() {
        cardView.anchor(to: contentView)
        
        backgroundImage.anchor(to: cardView)
        backgroundGradient.anchor(to: cardView)
        
        nameView.anchor(
            top: cardView.topAnchor,
            leading: cardView.leadingAnchor,
            trailing: cardView.trailingAnchor
        )
        
        infoView.anchor(
            leading: cardView.leadingAnchor,
            bottom: cardView.bottomAnchor,
            trailing: cardView.trailingAnchor
        )
    }
    
    //MARK: - Update Functions
    func updateViews() {
        if let imageUrl = fullLaunch?.getLaunchImageUrl() {
            cancellable = loadImage(for: imageUrl).sink { [unowned self] image in self.showImage(image: image)}
        } else {
            showImage(image: RKAssets.Images.placeholder.image)
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
    
    //MARK: - Interaction Functions
    @objc private func pressLaunch() {
        self.springAnimate()
    }
    
}
