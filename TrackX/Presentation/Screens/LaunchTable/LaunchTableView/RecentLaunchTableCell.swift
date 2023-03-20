//
//  LaunchTablePrimaryCell.swift
//  TrackX
//
//  Created by Oliver Stenning on 09/06/2022.
//

import RaptorKit
import UIKit
import Combine

class RecentLaunchTableCell: LaunchTableCell {
    
    //MARK: - Views
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
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        nameView.configure(with: fullLaunch)
        infoView.configure(with: fullLaunch)
        updateViews()
    }
    
    func configureViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        container.addSubview(backgroundImage)
        container.addSubview(backgroundGradient)
        container.addSubview(nameView)
        container.addSubview(infoView)
    }
    
    func configureConstaints() {
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
}
