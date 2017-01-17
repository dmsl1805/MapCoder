//
//  ViewController.swift
//  MapCoder
//
//  Created by Dmitriy Shulzhenko on 1/16/17.
//  Copyright © 2017 Dmitriy Shulzhenko. All rights reserved.
//

import UIKit

import Mapbox
import MapboxGeocoder

import MapKit

import PokeModal

class ViewController: UIViewController {

    var mapView: MapViewProtocol!
    
    var geocoder: GeocoderProtocol?
    
    var serviceModel: MapServiceModel!
    
    var modalInfo: PokeModal!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addMapView(MKMapView(frame: view.bounds))
        self.geocoder = AppleGeocoder()

        modalInfo = PokeModal(view: self.view)
        serviceModel = MapServiceModel(mapService: .apple, geoService: .apple, didChange: {
            [unowned self] (changedModel) in
            self.mapView.removeFromSuperview()
            self.serviceModel = changedModel
            print(changedModel.geoService, changedModel.mapService)
            switch changedModel.mapService {
            case .apple:
                self.addMapView(MKMapView(frame: self.view.bounds))
            case .mapbox:
                self.addMapView(MGLMapView(frame: self.view.bounds))
            }
            switch changedModel.geoService {
            case .apple:
                self.geocoder = AppleGeocoder()
            case .mapbox:
                self.geocoder = MapboxGeocoder(accessToken: nil)
            }
        })
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingsViewController = segue.destination as? SettingsViewController {
            settingsViewController.serviceModel = serviceModel
        }
    }
    
    func addMapView(_ mapView: MapViewProtocol) {
        self.mapView = mapView
        mapView.addToView(view)
        self.mapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.mapTapped(_:))))
    }
    
    @objc fileprivate func mapTapped(_ sender: Any?) {
        self.modalInfo.dismissMenu()

        let gestureReconizer = sender as! UIGestureRecognizer
        let location = mapView.locationFor(gestureRecognizer: gestureReconizer)
        let coordinate = mapView.convert(tapLocation: location)
        mapView.addAnnotation(coordinate: coordinate)
        geocoder?.reverseGeocodeLocation(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude),
                                         { (city, location, interests) in
                                            self.modalInfo.titleText = city ?? "Unknown city"
                                            if let loc = location {
                                                self.modalInfo.contentText = "Latitude \(loc.lat) Longitude\(loc.lon) \nPlace Description: \(interests ?? "")"
                                            }
                                            self.modalInfo.showMenu()
        })
    }
    
    fileprivate func addAnnotation() {
        
    }
    
}

