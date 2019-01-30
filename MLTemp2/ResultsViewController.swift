//
//  ResultsViewController.swift
//  MLTemp2
//
//  Created by CHONG LIU on 30/1/19.
//  Copyright © 2019 CHONG LIU. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var firstPrediction = ""
    var secondPrediction = ""
    var thirdPrediction = ""
    var firstConfidence = ""
    var secondConfidence = ""
    var thirdConfidence = ""
    
    @IBOutlet weak var firstResultLabel: UILabel!
    
    @IBOutlet weak var secondResultLabel: UILabel!
    
    @IBOutlet weak var thirdResultLabel: UILabel!
    
    
    @IBOutlet weak var firstPredictionButton: UIButton!
    
    @IBOutlet weak var secondPredictionButton: UIButton!
    
    @IBOutlet weak var thirdPredictionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstPredictionButton.setTitle(firstPrediction, for: UIControl.State.normal)
        secondPredictionButton.setTitle(secondPrediction, for: UIControl.State.normal)
        thirdPredictionButton.setTitle(thirdPrediction, for: UIControl.State.normal)
        firstResultLabel.text = firstConfidence
        secondResultLabel.text = secondConfidence
        thirdResultLabel.text = thirdConfidence
        
        let radius = firstPredictionButton.frame.height / 4
        firstPredictionButton.layer.cornerRadius = radius
        firstResultLabel.layer.cornerRadius = radius
        firstResultLabel.clipsToBounds = true
        secondPredictionButton.layer.cornerRadius = radius
        secondResultLabel.layer.cornerRadius = radius
        secondResultLabel.clipsToBounds = true
        thirdPredictionButton.layer.cornerRadius = radius
        thirdResultLabel.layer.cornerRadius = radius
        thirdResultLabel.clipsToBounds = true
    }
    
    @IBAction func firstResultButton(_ sender: Any) {
        let temp = firstPredictionButton.titleLabel?.text
        myIndex = birdSpecies.firstIndex(of: temp!)!
    }
    
    @IBAction func secondResultButton(_ sender: Any) {
        let temp = secondPredictionButton.titleLabel?.text
        myIndex = birdSpecies.firstIndex(of: temp!)!
    }
    
    @IBAction func thirdResultButton(_ sender: Any) {
        let temp = thirdPredictionButton.titleLabel?.text
        myIndex = birdSpecies.firstIndex(of: temp!)!
    }
    
}
