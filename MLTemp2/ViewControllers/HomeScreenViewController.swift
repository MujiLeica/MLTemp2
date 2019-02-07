//
//  HomeScreenViewController.swift
//  MLTemp2
//
//  Created by CHONG LIU on 28/1/19.
//  Copyright © 2019 CHONG LIU. All rights reserved.
//

import UIKit
import CoreLocation

var latitude = 0.0
var longitude = 0.0

class HomeScreenViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var offlineRecoButton: UIButton!
    @IBOutlet weak var liveRecoButton: UIButton!
    @IBOutlet weak var birdDataButton: UIButton!
    @IBOutlet weak var soundRecoButton: UIButton!
    @IBOutlet weak var onlineRecoButton: UIButton!
    
    let locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let radius = offlineRecoButton.frame.height / 4
        offlineRecoButton.layer.cornerRadius = radius
        liveRecoButton.layer.cornerRadius = radius
        //birdDataButton.layer.cornerRadius = radius
        soundRecoButton.layer.cornerRadius = radius
        onlineRecoButton.layer.cornerRadius = radius
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        else { return }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
            //print (latitude, longitude)
        }
        else {return}
    }
    

}
