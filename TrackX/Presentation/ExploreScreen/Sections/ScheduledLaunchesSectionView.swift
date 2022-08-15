//
//  ScheduledLaunchesCardView.swift
//  TrackX
//
//  Created by Oliver Stenning on 13/08/2022.
//

import UIKit

class ScheduledLaunchesSectionView: UIView {
    
    //MARK: - Views
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Scheduled"
        label.textColor = R.color.textColor()
        label.font = R.font.archivoSemiBold(size: 22)
        return label
    }()
    
    let showAllButton: UILabel = {
        let label = UILabel()
        label.text = "Show all"
        label.textColor = R.color.secondaryTextColor()
        label.font = R.font.rubikMedium(size: 16)
        return label
    }()
    
    let launchCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ScheduledLaunchCollectionCell.self, forCellWithReuseIdentifier: LaunchCellIdentifiers.scheduled)
        return collectionView
    }()
    
    //MARK: - Properties
    let launchProvider: LaunchProvider
    var scheduledDataSource: LaunchCollectionDataSource?
    
    //MARK: - Initializers
    init(launchProvider: LaunchProvider) {
        self.launchProvider = launchProvider
        super.init(frame: .zero)
        configureViews()
        configureConstraints()
        
        launchProvider.scheduledLaunchesDelegate = self
        launchProvider.fetchScheduledLaunches()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration Functions
    private func configureViews() {
        addSubview(titleLabel)
        addSubview(showAllButton)
        addSubview(launchCollectionView)
        launchCollectionView.delegate = self
    }
    
    private func configureConstraints() {
        let margin: CGFloat = 16
        
        titleLabel.anchor(
            top: self.topAnchor,
            leading: self.leadingAnchor,
            padding: .init(top: 0, left: margin, bottom: 0, right: 0)
        )
        
        showAllButton.anchor(
            trailing: self.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: margin)
        )
        showAllButton.anchorYCenter(to: titleLabel)
        
        launchCollectionView.anchor(
            top: titleLabel.bottomAnchor,
            leading: self.leadingAnchor,
            bottom: self.bottomAnchor,
            trailing: self.trailingAnchor,
            padding: .init(top: 12, left: 0, bottom: 0, right: 0)
        )
    }

}

extension ScheduledLaunchesSectionView: ScheduledLaunchesDelegate {
    func launchProvider(_ provider: LaunchProvider, launchesUpdated: [FullLaunch]) {
        scheduledDataSource = LaunchCollectionDataSource(launchType: .scheduled, launches: launchesUpdated)
        launchCollectionView.dataSource = scheduledDataSource
        if launchCollectionView.dataSource != nil {
            launchCollectionView.reloadData()
            print(launchCollectionView.collectionViewLayout.collectionViewContentSize)
        }
    }
}

extension ScheduledLaunchesSectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width - 40, height: launchCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 12, bottom: 0, right: 12)
    }
}

//extension ScheduledLaunchesSectionView: UIScrollViewDelegate {
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        self.launchCollectionView.scrollToNearestVisibleCollectionViewCell()
//    }
//
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        if !decelerate {
//            self.launchCollectionView.scrollToNearestVisibleCollectionViewCell()
//        }
//    }
//}
