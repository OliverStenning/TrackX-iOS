//
//  LocationsSectionStackView.swift
//  TrackX
//
//  Created by Oliver Stenning on 10/07/2022.
//

import UIKit
import MapKit

class LocationsSectionStackView: UIStackView, MKMapViewDelegate {
    
    //MARK: - Views
    private let sectionLabel = HeadingLabel(text: "Locations", size: .h2)
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.layer.cornerRadius = 12
        mapView.clipsToBounds = true
        mapView.mapType = .mutedStandard
        return mapView
    }()
    
    //MARK: - Properties
    
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration Functions
    func configureWith(launchpad: Launchpad, landpads: [Landpad]) {
        var mapLocations: [Location] = []
        
        if let latitude = launchpad.latitude, let longitude = launchpad.longitude {
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            mapLocations.append(Location(title: launchpad.name ?? "", coordinate: coordinate, type: .launchpad))
        }
        
        for landpad in landpads {
            if let latitude = landpad.latitude, let longitude = landpad.longitude {
                let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                mapLocations.append(Location(title: landpad.name ?? "", coordinate: coordinate, type: .landpad))
            }
        }
        
        for location in mapLocations {
            mapView.addAnnotation(location)
        }
        
        mapView.centerAroundLocations(mapLocations)
    }
    
    func configureWith(launchpad: Launchpad) {
        if let latitude = launchpad.latitude, let longitude = launchpad.longitude {
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            mapView.addAnnotation(Location(title: launchpad.name ?? "", coordinate: coordinate, type: .launchpad))
            mapView.centerToLocation(coordinate)
        }
        
    }
    
    private func configureViews() {
        axis = .vertical
        distribution = .fill
        spacing = 16
        
        mapView.delegate = self
        
        addArrangedSubview(sectionLabel)
        addArrangedSubview(mapView)
    }
    
    private func configureConstraints() {
        mapView.anchorSize(height: 400)
    }
    
    //MARK: - Update Functions
    private func updateViews() {

    }
    
    //MARK: - Map View
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Location else { return nil }
        let identifier = "Location"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        } else {
            annotationView?.annotation = annotation
        }
        
        let location = annotation as? Location
        switch location?.type {
            case .launchpad:
                annotationView?.markerTintColor = UIColor.systemBlue
                annotationView?.glyphTintColor = .black
            case .landpad:
                annotationView?.markerTintColor = UIColor.cyan
                annotationView?.glyphTintColor = .black
            case .none:
                annotationView?.markerTintColor = UIColor.cyan
                annotationView?.glyphTintColor = .black
        }
        
        return annotationView
    }
    
}

