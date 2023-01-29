//
//  RecentLaunchesCardView.swift
//  TrackX
//
//  Created by Oliver Stenning on 13/08/2022.
//

import RaptorKit
import UIKit

class RecentLaunchesSectionView: UIView {
    
    //MARK: - Views
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.recent
        label.textColor = RKAssets.Colors.textPrimary.color
        label.font = RKFonts.Archivo.semiBold.font(size: 22)
        return label
    }()
    
    private let showAllButton: UIButton = {
        let button = UIButton()
        button.setTitle(L10n.showAll, for: .normal)
        button.setTitleColor(RKAssets.Colors.accent.color, for: .normal)
        button.titleLabel?.font = RKFonts.Rubik.medium.font(size: 16)
        return button
    }()
    
    private let launchCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(RecentLaunchCollectionCell.self, forCellWithReuseIdentifier: LaunchCellIdentifiers.recent)
        return collectionView
    }()
    
    //MARK: - Properties
    private let launchProvider: LaunchProvider
    private var recentDataSource: LaunchCollectionDataSource?
    var delegate: RecentLaunchesSectionDelegate?
    
    //MARK: - Initializers
    init(launchProvider: LaunchProvider) {
        self.launchProvider = launchProvider
        super.init(frame: .zero)
        addViews()
        configureViews()
        configureConstraints()
        
        launchProvider.recentLaunchesDelegate = self
        launchProvider.fetchRecentLaunches()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration Functions
    private func addViews() {
        addSubview(titleLabel)
        addSubview(showAllButton)
        addSubview(launchCollectionView)
    }
    
    private func configureViews() {
        launchCollectionView.delegate = self
        showAllButton.addTarget(self, action: #selector(pressShowAll), for: .touchUpInside)
    }
    
    private func configureConstraints() {
        let margin: CGFloat = 16
        
        self.anchorSize(height: 240)
        
        titleLabel.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            padding: .init(top: margin, left: margin, bottom: 0, right: 0)
        )
        
        showAllButton.anchorYCenter(to: titleLabel)
        showAllButton.anchor(
            trailing: trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: margin)
        )
        
        launchCollectionView.anchor(
            top: titleLabel.bottomAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 12, left: 0, bottom: 0, right: 0)
        )
    }

    //MARK: - Interaction Functions
    @objc private func pressShowAll() {
        if let delegate = delegate {
            delegate.recentLaunchesSection(self, didSelectAllLaunches: true)
        }
    }
}

//MARK: - Launch Provider Delegate
extension RecentLaunchesSectionView: RecentLaunchesDelegate {
    func launchProvider(_ provider: LaunchProvider, launchesUpdated: [FullLaunch]) {
        recentDataSource = LaunchCollectionDataSource(launchType: .recent, launches: launchesUpdated)
        launchCollectionView.dataSource = recentDataSource
        if launchCollectionView.dataSource != nil {
            launchCollectionView.reloadData()
        }
    }
}

//MARK: - CollectionView Layout Delegate
extension RecentLaunchesSectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: frame.width - 40, height: launchCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}

extension RecentLaunchesSectionView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = delegate, let dataSource = recentDataSource {
            delegate.recentLaunchesSection(self, didSelectLaunch: dataSource.launches[indexPath.item])
        }
    }
}

protocol RecentLaunchesSectionDelegate {
    func recentLaunchesSection(_ recentLaunchesSection: RecentLaunchesSectionView, didSelectLaunch fullLaunch: FullLaunch)
    func recentLaunchesSection(_ recentLaunchesSection: RecentLaunchesSectionView, didSelectAllLaunches: Bool)
}
