//
//  ViewController.swift
//  OCR Test
//
//  Created by CDEV-TURKEY on 24.10.2019.
//  Copyright © 2019 CDEV-TURKEY. All rights reserved.
//

import UIKit
import WebKit
import PayCardsRecognizer

protocol isAbleToReceiveData {
  func pass(data: PayCardsRecognizerResult?)
}

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, UIScrollViewDelegate, WKScriptMessageHandler, isAbleToReceiveData {
    
    func pass(data: PayCardsRecognizerResult?) {
        let alert = UIAlertController(title: "Card Holder", message: data?.recognizedHolderName, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        self.webCallback = message.body as! String
        if webCallback == "Open Camera"{
            let detailVC = ScanViewController()
            detailVC.delegate = self
            self.navigationController?.modalPresentationStyle = .automatic
            present(detailVC, animated: true)
        }
    }
    
    var webView = WKWebView()
    var webCallback = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let config = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        userContentController.add(self, name: "cameraDetect")
        config.userContentController = userContentController

        webView = WKWebView(frame: view.bounds, configuration: config)
        webView.navigationDelegate = self
        
        let url = URL(string: "http://192.168.1.41:8080/")!
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
        webView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        view.addSubview(webView)
    }
    
}

