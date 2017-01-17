//
//  GeocoderProtocol.swift
//  MapCoder
//
//  Created by Dmitriy Shulzhenko on 1/17/17.
//  Copyright © 2017 Dmitriy Shulzhenko. All rights reserved.
//

import CoreLocation

protocol GeocoderBlockProtocol: class {
    func reverseGeocodeLocation(_ location: CLLocation, _ completion: @escaping ((_ city: String?, _ location: (lat: String, lon: String)?, _ interests: String?) -> Void))
}

protocol GeocoderDelegate: class {
    func geocoderFinished(city: String?, interests: String?)
}

protocol GeocoderDelegateProtocol: class {
    weak var delegate: GeocoderDelegate? { get set }
    func reverseGeocodeLocation(_ location: CLLocation)
}

protocol GeocoderProtocol: class, GeocoderDelegateProtocol, GeocoderBlockProtocol {
}
