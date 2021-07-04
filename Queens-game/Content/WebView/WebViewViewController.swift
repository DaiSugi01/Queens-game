//
//  PrivacyPolicyViewController.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-06-28.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {
  private var webView: WKWebView!
  private var contentURL: String!
  
  init(url: String) {
    super.init(nibName: nil, bundle: nil)
    contentURL = url
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let myURL = URL(string: contentURL)
    let myRequest = URLRequest(url: myURL!)
    webView.load(myRequest)
  }
  
}


extension WebViewViewController: WKUIDelegate  {
  override func loadView() {
    let webConfiguration = WKWebViewConfiguration()
    webView = WKWebView(frame: .zero, configuration: webConfiguration)
    webView.uiDelegate = self
    view = webView
  }
}





