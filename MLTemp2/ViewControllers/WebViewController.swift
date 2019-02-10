//
//  WebViewController.swift
//  MLTemp2
//
//  Created by CHONG LIU on 25/1/19.
//  Copyright © 2019 CHONG LIU. All rights reserved.
//

//  WebViewController displays the webpage showing metadata about a particular species

import UIKit
import WebKit

class WebViewController: UIViewController {

    
    @IBOutlet weak var birdWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // There will be a small glitch when loading the URL
        // That is a problem with the website not a bug in the App
        // I tried to load other websites and there's no glitch at all
        // Even by just copying this url into Safari there's a glitch as well
        let birdURL = URL(string: "http://www.birdsinbackyards.net/species/" + birdDataURL[myIndex])

        birdWebView.load(URLRequest(url: birdURL!))
    
    }

}
