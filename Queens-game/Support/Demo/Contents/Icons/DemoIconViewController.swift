//
//  IconViewController.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-25.
//

import UIKit

/// ⚠️ This is a demo ViewController. Do not use this class in release version.
///
/// This controller shows the usage of
/// - Icon image
/// - Icon image view
class DemoIconViewController: UIViewController {
  
  let icons: [IconType] = [.citizen, .allCitizen,.queen, .arrow, .cToC, .cToA, .cToQ, .levelOne, .levelTwo, .levelThree]

  override func viewDidLoad() {
    super.viewDidLoad()
    view.configBgColor(bgColor: CustomColor.background)
    
    let scroll = UIScrollView()
    scroll.configSuperView(under: view)
    scroll.matchParent()
    scroll.contentSize = .init(width: 0, height: 1000)
    
    /*
     How to use: Icon.
    
     - If you want to create imageView, call
     `IconFactory.createImageView(type: iconType, height: size))`
     - If you want to create image, call
     `IconFactory.createImage(type: iconType, height: size))`
     
     Exception
     - If you want to create user id icon (imageView), you also have to pass id
     `IconFactory.createImageView(type: .userId(7), width: 64))`
     - You can not create image of user id icon. This will return just empty UIImage
     `IconFactory.createImage(type: .userId(7), width: 64))`
     
    */
    let stack = VerticalStackView(arrangedSubviews:[], spacing: 32, alignment: .center)
    for icon in icons {
      stack.addArrangedSubview(IconFactory.createImageView(type: icon, height: 32))
    }
    stack.addArrangedSubview(IconFactory.createImageView(type: .userId(7), width: 64))
    
    stack.configSuperView(under: scroll)
    stack.centerXYin(scroll)

  }

}
