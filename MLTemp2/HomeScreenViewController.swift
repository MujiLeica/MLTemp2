//
//  HomeScreenViewController.swift
//  MLTemp2
//
//  Created by CHONG LIU on 28/1/19.
//  Copyright © 2019 CHONG LIU. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {

    @IBOutlet weak var offlineRecoButton: UIButton!
    @IBOutlet weak var liveRecoButton: UIButton!
    @IBOutlet weak var birdDataButton: UIButton!
    @IBOutlet weak var soundRecoButton: UIButton!
    @IBOutlet weak var onlineRecoButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        var radius = offlineRecoButton.frame.height / 2
        offlineRecoButton.layer.cornerRadius = radius
        liveRecoButton.layer.cornerRadius = radius
        birdDataButton.layer.cornerRadius = radius
        soundRecoButton.layer.cornerRadius = radius
        onlineRecoButton.layer.cornerRadius = radius
        
    }
    

}
