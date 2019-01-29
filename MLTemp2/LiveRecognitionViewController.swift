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


class LiveRecognitionViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    let identifierLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let captureSession = AVCaptureSession()
        
        // crop the video output screen a bit
        captureSession.sessionPreset = .photo
        
        // use back camera on the phone for AVCapture
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        
        captureSession.startRunning()
        
        // add an ouput preview layer of video
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        // get access to the data from camera frames
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
        
        setupIdentifierConfidenceLabel()
    }
    
    fileprivate func setupIdentifierConfidenceLabel() {
        view.addSubview(identifierLabel)
        identifierLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        identifierLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        identifierLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        identifierLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    // add a timer or switch for live recognition
    // save the highest confidence results
    

    // perform coreML request everytime the camera capture a frame
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        // select the coreML model
        guard let model = try? VNCoreMLModel(for: BirdClassifier().model) else { return }
        
        // fire up the request
        let request = VNCoreMLRequest(model: model) { (finishedReq, err) in

            // get the result
            guard let results = finishedReq.results as? [VNClassificationObservation] else { return }
            
            // display the first observation    ...    is the first observation the highest confidence one?
            guard let firstObservation = results.first else { return }
            
            let percentage = String(format: "%.4f", firstObservation.confidence * 100)
            
            //print(firstObservation.identifier, firstObservation.confidence)
            
//            DispatchQueue.main.async {
//                self.identifierLabel.text = "\(firstObservation.identifier) \(firstObservation.confidence * 100)"
            DispatchQueue.main.async {
                self.identifierLabel.text = "\(firstObservation.identifier) " + percentage
            }
            
        }
        
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
}
