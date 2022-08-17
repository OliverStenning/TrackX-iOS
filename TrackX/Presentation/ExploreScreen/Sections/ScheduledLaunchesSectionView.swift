//
//  ScheduledLaunchesCardView.swift
//  TrackX
//
//  Created by Oliver Stenning on 13/08/2022.
//

import UIKit

class ScheduledLaunchesSectionView: UIView {
    
    //MARK: - Views
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.scheduled()
        label.textColor = R.color.textColor()
        label.font = R.font.archivoSemiBold(size: 22)
        return label
    }()
    
    private let showAllButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.localizable.showAll(), for: .normal)
        button.setTitleColor(R.color.accentColor(), for: .normal)
        button.titleLabel?.font = R.font.rubikMedium(size: 16)
        return button
    }()
    
    private let launchCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ScheduledLaunchCollectionCell.self, forCellWithReuseIdentifier: LaunchCellIdentifiers.scheduled)
        return collectionView
    }()
    
    //MARK: - Properties
    private let launchProvider: LaunchProvider
    private var scheduledDataSource: LaunchCollectionDataSource?
    
    //MARK: - Initializers
    init(launchProvider: LaunchProvider) {
        self.launchProvider = launchProvider
        super.init(frame: .zero)
        addviews()
        configureViews()
        configureConstraints()
        
        launchProvider.scheduledLaunchesDelegate = self
        launchProvider.fetchScheduledLaunches()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration Functions
    private func addviews() {
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
        
        self.anchorSize(height: 180)
        
        titleLabel.anchor(
            top: self.topAnchor,
            leading: self.leadingAnchor,
            padding: .init(top: margin, left: margin, bottom: 0, right: 0)
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

    //MARK: - Interaction Functions
    @objc private func pressShowAll() {
        print("Pressed show all")
    }
    
}

extension ScheduledLaunchesSectionView: ScheduledLaunchesDelegate {
    func launchProvider(_ provider: LaunchProvider, launchesUpdated: [FullLaunch]) {
        scheduledDataSource = LaunchCollectionDataSource(launchType: .scheduled, launches: launchesUpdated)
        launchCollectionView.dataSource = scheduledDataSource
        if launchCollectionView.dataSource != nil {
            launchCollectionView.reloadData()
        }
    }
}

extension ScheduledLaunchesSectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width - 40, height: launchCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}
