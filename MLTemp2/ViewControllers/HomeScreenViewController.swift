//
//  HomeScreenViewController.swift
//  MLTemp2
//
//  Created by CHONG LIU on 28/1/19.
//  Copyright © 2019 CHONG LIU. All rights reserved.
//

//  This ViewController is the home screen of the App.
//  It displays different recognition options and ask user for location permission
//  in order to load the most accuracy model for recognition in other ViewControllers

import UIKit
import CoreLocation

// location variables for use in other VCs
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
        // consistent UI look throughout the application
        let radius = offlineRecoButton.frame.height / 4
        offlineRecoButton.layer.cornerRadius = radius
        liveRecoButton.layer.cornerRadius = radius
        //birdDataButton.layer.cornerRadius = radius
        soundRecoButton.layer.cornerRadius = radius
        onlineRecoButton.layer.cornerRadius = radius
        
        // ask for user's permission for location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        else { return }
        
    }
    
    // getting user's location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
            //print (latitude, longitude)
        }
        else {return}
    }
    

}
