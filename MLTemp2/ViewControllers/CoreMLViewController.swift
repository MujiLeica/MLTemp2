//
//  ViewController.swift
//  MLTemp2
//
//  Created by CHONG LIU on 20/12/18.
//  Copyright © 2018 CHONG LIU. All rights reserved.
//

//  This ViewController performs offline image recognition using Core ML
//  Users can choose a photo from the photo library or take a new one
//  The camera function is just a basic camera
//  because the iPhone's native camera is pretty good already.
//  There's no point to reinvent the wheel to reproduce iPhone native camera
//  Users are encouraged to use iPhones native camera to take photos and do the recognition process in the app because all of the native camera features like zoom, grid, flash, brightness and so on


import UIKit
import CoreML
import Vision // Vision framework is used to connect camera data and Core ML

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    //@IBOutlet weak var predictionLabel: UILabel!
    
    @IBOutlet weak var predictionButton: UIButton!
    
    //@IBOutlet weak var confidenceLabel: UILabel!
    @IBOutlet weak var confidenceButton: UIButton!
    
    // Bird species and confidence waiting to be passed to ResultViewController
    var first = ""
    var second = ""
    var third = ""
    var firstConfidence: Float = 0
//    var secondConfidence = ""
//    var thirdConfidence = ""
    var secondConfidence: Float = 0
    var thirdConfidence: Float = 0
    
    // we can load the most accurate model according to user's location
    var birdClassificationModel = Crop()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let radius = predictionButton.frame.height / 4
        predictionButton.layer.cornerRadius = radius
        confidenceButton.layer.cornerRadius = radius
        self.predictionButton.isEnabled = false
        self.confidenceButton.isEnabled = false
    }
    
    // Function to be called to process the image recognition
    // It returns 3 most confident results just in case the first result is incorrect
    func processImage(image: UIImage) {
        if let model = try? VNCoreMLModel(for: self.birdClassificationModel.model) {
            let request = VNCoreMLRequest(model: model) { (request, error) in
                if let results = request.results as? [VNClassificationObservation] {
                    

                    let topClassifications = results.prefix(3)
                    let descriptions = topClassifications.map { classification in
                        // Formats the classification for display; e.g. "(0.37) cliff, drop, drop-off".
                        //return String(format: "  (%.4f) %@", classification.confidence, classification.identifier)
                        return String(format: "%@", classification.identifier)
                    }
                    
                    let confidenceDescriptions = topClassifications.map { classification in
            
                        //return String(format: "  (%.4f) %@", classification.confidence, classification.identifier)
                        //return String(format: "%.4f", classification.confidence)
                        return classification.confidence
                    }
                    print ("Top Classifications")
                    print (descriptions)
                    
                    self.first = descriptions[0]
                    self.second = descriptions[1]
                    self.third = descriptions[2]
                    
                    self.firstConfidence = confidenceDescriptions[0]
                    self.secondConfidence = confidenceDescriptions[1]
                    self.thirdConfidence = confidenceDescriptions[2]
                    
            
                    let species = results.first?.identifier
                    
                    self.predictionButton.setTitle(species, for: UIControl.State.normal)

                    if species != "Prediction" {
                        self.predictionButton.isEnabled = true
                        myIndex = birdSpecies.firstIndex(of: species!)!
                    }
                    
                    
                    
                    if let temp = results.first?.confidence {
                        self.confidenceButton.setTitle(String(format: "%.4f", temp * 100) + "%", for: UIControl.State.normal)
                        self.confidenceButton.isEnabled = true
                    }
                
                }
            }
            if let imageData = image.pngData() {
                let handler = VNImageRequestHandler(data: imageData, options: [:])
                try? handler.perform([request])
            }
        }
    }
    
    
    // image picker functions
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
    
    // image picker controll setup
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.image = selectedImage
            processImage(image: selectedImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // passing data between ViewControllers using segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "photoToResult" {
            let vc = segue.destination as! ResultsViewController
            vc.firstPrediction = self.first
            vc.secondPrediction = self.second
            vc.thirdPrediction = self.third
            vc.firstConfidence = self.firstConfidence
            vc.secondConfidence = self.secondConfidence
            vc.thirdConfidence = self.thirdConfidence
        }
        
    }
}

