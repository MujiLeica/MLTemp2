//
//  WebViewController.swift
//  MLTemp2
//
//  Created by CHONG LIU on 25/1/19.
//  Copyright © 2019 CHONG LIU. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var birdWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let myurl = URL(string: "http://www.birdsinbackyards.net/species/Alisterus-scapularis")
//
//        birdWebView.loadRequest(URLRequest(url: myurl!))
        
        let birdURL = URL(string: "http://www.birdsinbackyards.net/species/" + birdDataURL[myIndex])

        birdWebView.loadRequest(URLRequest(url: birdURL!))
    }

}
