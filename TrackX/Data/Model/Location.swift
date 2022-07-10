//
//  Location.swift
//  TrackX
//
//  Created by Oliver Stenning on 10/07/2022.
//

import Foundation
import MapKit

enum LocationType {
    case launchpad
    case landpad
}

class Location: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var type: LocationType
    
    init(title: String, coordinate: CLLocationCoordinate2D, type: LocationType) {
        self.title = title
        self.coordinate = coordinate
        self.type = type
    }
}
