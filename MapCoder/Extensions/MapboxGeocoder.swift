//
//  GeocoderProtocol.swift
//  MapCoder
//
//  Created by Dmitriy Shulzhenko on 1/17/17.
//  Copyright © 2017 Dmitriy Shulzhenko. All rights reserved.
//

import MapboxGeocoder


class MapboxGeocoder: Geocoder, GeocoderProtocol {
    
    weak var delegate: GeocoderDelegate?
    
    func reverseGeocodeLocation(_ location: CLLocation) {
        self.reverseGeocodeLocation(location) { [unowned self] (city, _, interests) in
            self.delegate?.geocoderFinished(city: city, interests: interests)
        }
    }
    
    func reverseGeocodeLocation(_ location: CLLocation, _ completion: @escaping ((_ city: String?, _ location: (lat: String, lon: String)?, _ interests: String?) -> Void)) {
        let _ = self.geocode(ReverseGeocodeOptions(location: location)) { (placemark, copyright, error) in
            if let place = placemark?.last {
                completion(place.description, (location.coordinate.latitude.description, location.coordinate.longitude.description), copyright)
                
            }
        }
    }
}
