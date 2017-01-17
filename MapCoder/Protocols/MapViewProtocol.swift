//
//  MapViewProtocol.swift
//  MapCoder
//
//  Created by Dmitriy Shulzhenko on 1/17/17.
//  Copyright © 2017 Dmitriy Shulzhenko. All rights reserved.
//

import CoreLocation
import UIKit

protocol MapViewProtocol: class {
    func addAnnotation(coordinate: CLLocationCoordinate2D)
    func addToView(_ view: UIView)
    func removeFromSuperview()
    func addGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer)
    func locationFor(gestureRecognizer: UIGestureRecognizer) -> CGPoint
    func convert(tapLocation: CGPoint) -> CLLocationCoordinate2D
}
