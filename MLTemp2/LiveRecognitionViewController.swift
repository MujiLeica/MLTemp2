//
//  LiveRecognitionViewController.swift
//  MLTemp2
//
//  Created by CHONG LIU on 24/12/18.
//  Copyright © 2018 CHONG LIU. All rights reserved.
//

import UIKit
import AVKit
import Vision
import CoreML


class LiveRecognitionViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var predictionLabel: UILabel!
    
    
    var confidence = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let radius = startButton.frame.height / 4
        startButton.layer.cornerRadius = radius
        
        // start the camera
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        // run back camera on the phone for AVCapture
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        captureSession.startRunning()
        
        // add an ouput preview layer of the video
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        // access data from camera frames
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
    }

    // perform coreML request everytime the camera capture a frame
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        // select the coreML model according to user's location
        guard let model = try? VNCoreMLModel(for: BirdClassifier().model) else { return }
        
        // fire up the request
        let request = VNCoreMLRequest(model: model) { (finishedReq, err) in

            // get the result
            guard let results = finishedReq.results as? [VNClassificationObservation] else { return }
            
            // display the first observation
            guard let firstObservation = results.first else { return }
            
            self.confidence = Int ( firstObservation.confidence * 100 )
            
            var message = ""
            if self.confidence >= 50 { message = "\(firstObservation.identifier) " + "\(self.confidence)" + "%"}
            else { message = "The App is not sure about species"}
            
            DispatchQueue.main.async {
                self.predictionLabel.text = message
            }
            
            if ( self.confidence >= 85 ){
                let finalPrediction = "The App is \(self.confidence) % confident this bird is \(firstObservation.identifier)"
                self.readResults(message: finalPrediction, language: "en_EN")
            }
            
        }
        
        if (self.confidence <= 85) {
            try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
        }
    }
    
    func readResults (message: String, language: String) {
        let utterance = AVSpeechUtterance(string: message)
        utterance.voice = AVSpeechSynthesisVoice(language: language)
        utterance.rate = 0.5
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    
    @IBAction func startButtonTapped(_ sender: Any) {
        self.confidence = 0
    }
    
    
}
