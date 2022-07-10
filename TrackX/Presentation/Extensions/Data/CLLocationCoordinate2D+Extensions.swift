//
//  CLLocationCoordinate2D+Extensions.swift
//  TrackX
//
//  Created by Oliver Stenning on 10/07/2022.
//

import Foundation
import CoreLocation
import MapKit

extension CLLocationCoordinate2D {
    
    func distance(to: CLLocationCoordinate2D) -> CLLocationDistance {
        MKMapPoint(self).distance(to: MKMapPoint(to))
    }
    
}
