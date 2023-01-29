//
//  PhotoReelSectionView.swift
//  TrackX
//
//  Created by Oliver Stenning on 15/08/2022.
//

import RaptorKit
import UIKit

class PhotoReelSectionView: UIView {

    //MARK: - Views
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.latestPhotos
        label.textColor = RKAssets.Colors.textColor.color
        label.font = RKFonts.Archivo.semiBold.font(size: 22)
        return label
    }()

    private let photoCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(PhotoCollectionCell.self, forCellWithReuseIdentifier: PhotoCellIdentifiers.photo)
        return collectionView
    }()

    //MARK: - Properties
    private let collectionHeight: CGFloat = 200
    private var photoDataSource: PhotoCollectionDataSource?

    //MARK: - Initializers
    init() {
        super.init(frame: .zero)
        addViews()
        configureViews()
        configureConstraints()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Configuration Functions
    private func addViews() {
        addSubview(titleLabel)
        addSubview(photoCollectionView)
    }
    
    private func configureViews() {
        photoDataSource = PhotoCollectionDataSource(collectionHeight: collectionHeight)
        photoCollectionView.dataSource = photoDataSource
        photoCollectionView.delegate = photoDataSource
    }

    private func configureConstraints() {
        let margin: CGFloat = 16

        titleLabel.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            padding: .init(top: margin, left: margin, bottom: 0, right: 0)
        )

        photoCollectionView.anchorSize(height: collectionHeight)
        photoCollectionView.anchor(
            top: titleLabel.bottomAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 12, left: 0, bottom: 0, right: 0)
        )
    }
}
