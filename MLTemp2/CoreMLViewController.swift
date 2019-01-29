//
//  ViewController.swift
//  MLTemp2
//
//  Created by CHONG LIU on 20/12/18.
//  Copyright © 2018 CHONG LIU. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    //@IBOutlet weak var predictionLabel: UILabel!
    
    @IBOutlet weak var predictionButton: UIButton!
    
    @IBOutlet weak var confidenceLabel: UILabel!
    
    
    
    let birdClassificationModel = BirdClassifier()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.predictionButton.isEnabled = false
    }

    func processImage(image: UIImage) {
        if let model = try? VNCoreMLModel(for: self.birdClassificationModel.model) {
            let request = VNCoreMLRequest(model: model) { (request, error) in
                if let results = request.results as? [VNClassificationObservation] {
                    // print out all predictions
//                    for classification in results {
//                        print("ID:\(classification.identifier) Confidence:\(classification.confidence)")
//                    }
                    
                    let species = results.first?.identifier
                    
                    self.predictionButton.setTitle(species, for: UIControl.State.normal)

                    if species != "Prediction" {
                        self.predictionButton.isEnabled = true
                        myIndex = birdSpecies.firstIndex(of: species!)!
                    }
                    
                    
                    
                    if let temp = results.first?.confidence {
                        self.confidenceLabel.text = "\(temp * 100.0)%"
                    }
                }
            }
            if let imageData = image.pngData() {
                let handler = VNImageRequestHandler(data: imageData, options: [:])
                try? handler.perform([request])
            }
        }
    }
    
    
    
    @IBAction func CameraTapped(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a Source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera)
            {
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
            else
            {
                print("Camera not available")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Liabrary", style: .default, handler: { (action:UIAlertAction) in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
        
//        imagePicker.sourceType = .photoLibrary
//        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.image = selectedImage
            processImage(image: selectedImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

