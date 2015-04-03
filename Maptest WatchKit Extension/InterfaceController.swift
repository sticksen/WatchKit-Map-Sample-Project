//
//  InterfaceController.swift
//  Maptest WatchKit Extension
//
//  Created by stickbook  on 03.04.15.
//  Copyright (c) 2015 sticksen. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController, CLLocationManagerDelegate {

    @IBOutlet weak var map: WKInterfaceMap!
    let manager: CLLocationManager = CLLocationManager()
    
    override init() {
        super.init()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
    }

    override func willActivate() {
        super.willActivate()
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            manager.startUpdatingLocation()
        } else {
            manager.requestWhenInUseAuthorization()
        }
    }

    override func didDeactivate() {
        super.didDeactivate()
        manager.stopUpdatingLocation()
    }

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        map.removeAllAnnotations()
        if locations.count > 0 {
            if let location = locations[0] as? CLLocation {
                map.addAnnotation(location.coordinate, withPinColor: .Red)
                let region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                map.setRegion(region)
                manager.stopUpdatingLocation()
            }
        }
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
}
