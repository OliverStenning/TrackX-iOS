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
    var delegate: ScheduledLaunchesSectionDelegate?
    var launchCollectionViewDelegate: UICollectionViewDelegate?
    
    //MARK: - Initializers
    init(launchProvider: LaunchProvider) {
        self.launchProvider = launchProvider
        super.init(frame: .zero)
        addViews()
        configureViews()
        configureConstraints()

        launchCollectionViewDelegate = self
        launchProvider.scheduledLaunchesDelegate = self
        launchProvider.fetchScheduledLaunches()
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
        launchCollectionView.delegate = launchCollectionViewDelegate
        showAllButton.addTarget(self, action: #selector(pressShowAll), for: .touchUpInside)
    }
    
    private func configureConstraints() {
        let margin: CGFloat = 16
        
        self.anchorSize(height: 180)
        
        titleLabel.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            padding: .init(top: margin, left: margin, bottom: 0, right: 0)
        )
        
        showAllButton.anchor(
            trailing: trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: margin)
        )
        showAllButton.anchorYCenter(to: titleLabel)
        
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
        if let delegate = delegate, let dataSource = scheduledDataSource {
            delegate.scheduledLaunchesSection(self, allLaunchesSelected: dataSource.launches)
        }
    }
    
}

//MARK: - Launch Provider Delegate
extension ScheduledLaunchesSectionView: ScheduledLaunchesDelegate {
    func launchProvider(_ provider: LaunchProvider, launchesUpdated: [FullLaunch]) {
        scheduledDataSource = LaunchCollectionDataSource(launchType: .scheduled, launches: launchesUpdated)
        launchCollectionView.dataSource = scheduledDataSource
        launchCollectionView.delegate = self
        if launchCollectionView.dataSource != nil {
            launchCollectionView.reloadData()
        }
    }
}

//MARK: - CollectionView Delegate
extension ScheduledLaunchesSectionView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = delegate, let dataSource = scheduledDataSource {
            delegate.scheduledLaunchesSection(self, launchSelected: dataSource.launches[indexPath.item])
        }
    }
}

//MARK: - CollectionView Layout Delegate
extension ScheduledLaunchesSectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width - 40, height: launchCollectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}

protocol ScheduledLaunchesSectionDelegate {
    func scheduledLaunchesSection(_ section: ScheduledLaunchesSectionView, launchSelected: FullLaunch)
    func scheduledLaunchesSection(_ section: ScheduledLaunchesSectionView, allLaunchesSelected: [FullLaunch])
}