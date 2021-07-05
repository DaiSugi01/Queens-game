//
//  FontViewController.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-25.
//

import UIKit


/// ⚠️ This is a demo ViewController. Do not use this class in release version.
///
/// This controller shows the usage of
///  - Each Custom UILabel
class DemoFontViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.configureBgColor(bgColor: .white)
    
    // Configure scroll view
    let scroll = UIScrollView()
    scroll.configureSuperView(under: view)
    scroll.matchParent()
    scroll.contentSize = .init(width: 0, height: 1000)

    let stack = VerticalStackView(
      arrangedSubviews: [
        /*
         How to use: Custom Labels
        
         - You can just call `H1Label()`
         - You can also pass `text` (optional)
        */
        H1Label(text: "H1Label"),
        H2Label(text: "H2Label"),
        H3Label(text: "H3Label"),
        H4Label(text: "H4Label"),
        PLabel(text: "PLabel")
      ],
      spacing: 32
    )

    stack.configureSuperView(under: scroll)
    stack.centerXYin(scroll)
  }
}
