//
//  MKMapViewExtension.swift
//  MapCoder
//
//  Created by Dmitriy Shulzhenko on 1/17/17.
//  Copyright © 2017 Dmitriy Shulzhenko. All rights reserved.
//

import MapKit

extension MKMapView: MapViewProtocol {

    func addAnnotation(coordinate: CLLocationCoordinate2D) {
        if let annotation = annotations.first as? MKPointAnnotation {
            annotation.coordinate = coordinate
        } else {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            addAnnotation(annotation)
        }
    }
    
    func addToView(_ view: UIView) {
        view.addSubview(self)
    }

    func locationFor(gestureRecognizer: UIGestureRecognizer) -> CGPoint {
        return gestureRecognizer.location(in: self)
    }
    
    func convert(tapLocation: CGPoint) -> CLLocationCoordinate2D {
        return self.convert(tapLocation, toCoordinateFrom: self)
    }


}
