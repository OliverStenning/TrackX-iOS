//
//  PhotoCollectionDataSource.swift
//  TrackX
//
//  Created by Oliver Stenning on 15/08/2022.
//

import RaptorKit
import UIKit

struct PhotoCellIdentifiers {
    static let photo = "photo"
}

class PhotoCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    //MARK: - Properties
    let collectionHeight: CGFloat
    var photos: [UIImage] = [
        RKAssets.Images.placeholder1.image,
        RKAssets.Images.placeholder2.image,
        RKAssets.Images.placeholder3.image,
        RKAssets.Images.placeholder4.image,
        RKAssets.Images.placeholder5.image
    ]
    
    //MARK: - Initialziers
    init(collectionHeight: CGFloat) {
        self.collectionHeight = collectionHeight
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCellIdentifiers.photo, for: indexPath) as! PhotoCollectionCell
        cell.configure(with: photos[indexPath.item])
        return cell
    }
}

extension PhotoCollectionDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let image = photos[indexPath.item]
        let height = image.size.height
        let width = image.size.width

        let scaleFactor = width / height
        return CGSize(width: (collectionHeight * scaleFactor + 12), height: collectionHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}
