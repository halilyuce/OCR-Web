//
//  ScanViewController.swift
//  OCR Test
//
//  Created by CDEV-TURKEY on 24.10.2019.
//  Copyright © 2019 CDEV-TURKEY. All rights reserved.
//

import UIKit
import PayCardsRecognizer

class ScanViewController: UIViewController {
    
    var delegate: isAbleToReceiveData?

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var recognizerContainer: UIView!
    private var recognizer: PayCardsRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recognizer = PayCardsRecognizer(delegate: self, resultMode: .async, container: recognizerContainer, frameColor: .green)
    }
    
    @IBAction func closeFunc(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startCapturing()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        stopCapturing()
        navigationItem.rightBarButtonItem = nil
    }

}

// MARK: - Camera capturing
extension ScanViewController {
    private func startCapturing() {
        recognizer.startCamera()
    }
    
    private func stopCapturing() {
        recognizer.stopCamera()
    }
}

// MARK: - PayCardsRecognizerPlatformDelegate
extension ScanViewController: PayCardsRecognizerPlatformDelegate {
    func payCardsRecognizer(_ payCardsRecognizer: PayCardsRecognizer, didRecognize result: PayCardsRecognizerResult) {
        
        if result.isCompleted {
                dismiss(animated: true, completion: {
                    self.delegate?.pass(data: result)
                })
        }
    }
}
