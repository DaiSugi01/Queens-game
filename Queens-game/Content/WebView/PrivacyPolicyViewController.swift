//
//  PrivacyPolicyViewController.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-06-28.
//

import UIKit
import WebKit

class PrivacyPolicyViewController: UIViewController {
  var webView: WKWebView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let myURL = URL(string:"https://daisugi01.github.io/Queens-game/privacy")
    let myRequest = URLRequest(url: myURL!)
    webView.load(myRequest)
  }
  
}


extension PrivacyPolicyViewController: WKUIDelegate  {
  override func loadView() {
    let webConfiguration = WKWebViewConfiguration()
    webView = WKWebView(frame: .zero, configuration: webConfiguration)
    webView.uiDelegate = self
    view = webView
  }
}





