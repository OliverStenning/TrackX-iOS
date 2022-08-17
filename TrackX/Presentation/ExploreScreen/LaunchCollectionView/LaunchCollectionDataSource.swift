//
//  LaunchCollectionDataSource.swift
//  TrackX
//
//  Created by Oliver Stenning on 14/08/2022.
//

import UIKit

struct LaunchCellIdentifiers {
    static let scheduled = "LaunchCellScheduled"
    static let recent = "LaunchCellRecent"
}

enum CollectionLaunchType {
    case scheduled
    case recent
}

class LaunchCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    //MARK: - Properties
    let launchType: CollectionLaunchType
    var launches: [FullLaunch]
    
    //MARK: - Initializers
    init(launchType: CollectionLaunchType, launches: [FullLaunch]) {
        self.launchType = launchType
        self.launches = launches
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        launches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch launchType {
            case .scheduled:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchCellIdentifiers.scheduled, for: indexPath) as! ScheduledLaunchCollectionCell
                cell.configure(with: launches[indexPath.item])
                return cell
            case .recent:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchCellIdentifiers.recent, for: indexPath) as! RecentLaunchCollectionCell
                cell.configure(with: launches[indexPath.item])
                return cell
        }
    }
}

extension LaunchCollectionDataSource: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Test datasource")
    }
}
