//
//  SettingsViewController.swift
//  MapCoder
//
//  Created by Dmitriy Shulzhenko on 1/16/17.
//  Copyright © 2017 Dmitriy Shulzhenko. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    var serviceModel: MapServiceModel!
    
    fileprivate var indexPathForSelectedMap: IndexPath!
    fileprivate var indexPathForSelectedGeo: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateIndexPaths()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.cellForRow(at: indexPathForSelectedGeo)?.accessoryType = .checkmark
        tableView.cellForRow(at: indexPathForSelectedMap)?.accessoryType = .checkmark
        tableView.allowsMultipleSelection = false
        tableView.allowsSelection = true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath != indexPathForSelectedMap {
                tableView.cellForRow(at: indexPathForSelectedMap)?.accessoryType = .none
                switch indexPath.row {
                case 0:
                    serviceModel?.mapService = .apple
                case 1:
                    serviceModel?.mapService = .mapbox
                default:
                    break
                }
            }
            break
        case 1:
            if indexPath != indexPathForSelectedGeo {
                tableView.cellForRow(at: indexPathForSelectedGeo)?.accessoryType = .none
                switch indexPath.row {
                case 0:
                    serviceModel?.geoService = .apple
                case 1:
                    serviceModel?.geoService = .mapbox
                default:
                    break
                }
            }
            break
        default:
            break
        }
        
        updateIndexPaths()
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func updateIndexPaths() {
        switch self.serviceModel.mapService {
        case .apple:
            indexPathForSelectedMap = IndexPath(row: 0, section: 0)
        case .mapbox:
            indexPathForSelectedMap = IndexPath(row: 1, section: 0)
        }
        
        switch self.serviceModel.geoService {
        case .apple:
            indexPathForSelectedGeo = IndexPath(row: 0, section: 1)
        case .mapbox:
            indexPathForSelectedGeo = IndexPath(row: 1, section: 1)
        }
    }

}
