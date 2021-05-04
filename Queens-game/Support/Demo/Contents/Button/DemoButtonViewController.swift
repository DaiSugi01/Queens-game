//
//  ButtonViewController.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-25.
//

import UIKit

/// ⚠️ This is a demo ViewController. Do not use this class in release version.
/// 
/// This controller shows the usage of
///  - MainButton
///  - SubButton
///  - NextAndBackButtons
class DemoButtonViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.configBgColor(bgColor: .white)
    
    // Configure scroll view
    let scroll = UIScrollView()
    scroll.configSuperView(under: view)
    scroll.matchParent()
    scroll.contentSize = .init(width: 0, height: 1000)
    
    /*
     How to use: Custom UIButtons
    
     - You can just call like `MainButton()`
     - You can also change background color of bo=utton
    */
    let nextButton = MainButton()
    let backButton  = SubButton()
    
    let nextRedButton = MainButton()
    nextRedButton.configBgColor(bgColor: CustomColor.accent)
 
    let backNextButtons = NextAndBackButtons()

    let stack = VerticalStackView(
      arrangedSubviews: [nextButton, backButton, nextRedButton,  backNextButtons],
      spacing: 64
    )
    
    stack.configSuperView(under: scroll)
    stack.centerXYin(scroll)

    
  }

}
