//
//  MKMapView+Extensions.swift
//  TrackX
//
//  Created by Oliver Stenning on 10/07/2022.
//

import Foundation
import MapKit

extension MKMapView {
    
    func centerToLocation(_ location: CLLocationCoordinate2D, regionRadius: CLLocationDistance = 1000000) {
        let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: false)
    }
    
    func centerAroundLocations(_ locations: [Location]) {
        var centerLongitude: Double = 0
        var centerLatitude: Double = 0
        
        for location in locations {
            centerLongitude += location.coordinate.longitude
            centerLatitude += location.coordinate.latitude
        }
        
        centerLongitude /= Double(locations.count)
        centerLatitude /= Double(locations.count)
    
        var largestDistance: Double = 0
        
        for x in 0 ..< locations.count {
            for y in x + 1 ..< locations.count {
                let distance = locations[x].coordinate.distance(to: locations[y].coordinate)
                if distance > largestDistance {
                    largestDistance = distance
                }
            }
        }
        
        centerToLocation(CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude), regionRadius: largestDistance * 2)
    }
    
    
    
}
