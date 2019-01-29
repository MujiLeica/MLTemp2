//
//  WebViewController.swift
//  MLTemp2
//
//  Created by CHONG LIU on 25/1/19.
//  Copyright © 2019 CHONG LIU. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    
    @IBOutlet weak var birdWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let myurl = URL(string: "http://www.birdsinbackyards.net/species/Alisterus-scapularis")
//
//        birdWebView.loadRequest(URLRequest(url: myurl!))
        
        let birdURL = URL(string: "http://www.birdsinbackyards.net/species/" + birdDataURL[myIndex])

        birdWebView.load(URLRequest(url: birdURL!))

        //birdWebView.loadHTMLString("http://www.birdsinbackyards.net/species/" + birdDataURL[myIndex], baseURL: nil)
    }

}
