//
//  MapServiceModel.swift
//  MapCoder
//
//  Created by Dmitriy Shulzhenko on 1/16/17.
//  Copyright © 2017 Dmitriy Shulzhenko. All rights reserved.
//

import Foundation

struct MapServiceModel {
    
    enum Service {
        case apple
        case mapbox
    }
    
    var mapService: Service {
        didSet {
            didChange?(self)
        }
    }
    
    var geoService: Service {
        didSet {
            didChange?(self)
        }
    }
    
    var didChange: ((_ newValue: MapServiceModel) -> Void)?
}
