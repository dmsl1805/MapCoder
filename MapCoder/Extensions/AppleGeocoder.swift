//
//  CLGeocoderExtension.swift
//  MapCoder
//
//  Created by Dmitriy Shulzhenko on 1/17/17.
//  Copyright © 2017 Dmitriy Shulzhenko. All rights reserved.
//

import CoreLocation

class AppleGeocoder: CLGeocoder, GeocoderProtocol {
    
    weak var delegate: GeocoderDelegate?
    
    func reverseGeocodeLocation(_ location: CLLocation) {
        self.reverseGeocodeLocation(location) { [unowned self] (city, _, interests) in
            self.delegate?.geocoderFinished(city: city, interests: interests)
        }
    }

    func reverseGeocodeLocation(_ location: CLLocation, _ completion: @escaping ((_ city: String?, _ location: (lat: String, lon: String)?, _ interests: String?) -> Void)) {
        reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            print(location)
            
            if error != nil {
                completion(error?.localizedDescription, nil, nil)
                return
            }
            
            if let palcemrks = placemarks, palcemrks.count > 0 {
                let pm = palcemrks[0]
                print(pm.locality ?? "locality = nil")
                let placemark = placemarks?[0]
                
                let location = placemark?.location
                let coordinate = location?.coordinate
                print("\nlat: \(coordinate!.latitude), long: \(coordinate!.longitude)")
                if let areas = placemark?.areasOfInterest, areas.count > 0 {
                    let areaOfInterest = placemark!.areasOfInterest![0]
                    print(areaOfInterest)
                    completion(pm.locality, (coordinate!.latitude.description, coordinate!.longitude.description), areaOfInterest)
                } else {
                    completion(pm.locality, (coordinate!.latitude.description, coordinate!.longitude.description), "Nothing interesting here")
                }
            } else {
                print("Problem with the data received from geocoder")
                completion("Problem with the data received from geocoder", nil, nil)
                
            }
        })
    }
}
