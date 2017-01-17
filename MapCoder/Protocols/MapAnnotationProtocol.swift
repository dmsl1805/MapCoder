//
//  MapAnnotationProtocol.swift
//  MapCoder
//
//  Created by Dmitriy Shulzhenko on 1/17/17.
//  Copyright © 2017 Dmitriy Shulzhenko. All rights reserved.
//

import CoreLocation

protocol MapAnnotationProtocol: class {
    var coordinate: CLLocationCoordinate2D { get set }
}
