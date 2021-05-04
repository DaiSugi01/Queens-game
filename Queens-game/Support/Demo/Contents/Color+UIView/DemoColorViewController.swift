//
//  ColorViewController.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-25.
//

import UIKit


/// ⚠️ This is a demo ViewController. Do not use this class in release version.
///
/// This controller shows the usage of
///  - Custom UIColors
///  - Custom configuration of UIView
class DemoColorViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    /*
     How to use: UIView custom configuration
    
     - You can all like `someView.configureName()`
     - You can configure background color, size... etc (see the extension files)
     - You can configure those at once by calling `configureLayout`
    */
    view.configBgColor(bgColor: .cyan)
    
    let scroll = UIScrollView()
    scroll.configSuperView(under: view)
    scroll.matchParent()
    scroll.contentSize = .init(width: 0, height: 1500)
    
    let stack = VerticalStackView(
      arrangedSubviews: [
        /*
         How to use: Custom UIcolor
        
         - You can use by `CustomColor.color`
        */
        createUIView(200, 100, CustomColor.main, "main \n Used for text color"),
        createUIView(200, 100, CustomColor.subMain, "sub-main \n Used for supplement text color"),
        createUIView(200, 100, CustomColor.background, "background \n Used for main background"),
        createUIView(200, 100, CustomColor.convex, "convex \n Used for background which is upper, like card"),
        createUIView(200, 100, CustomColor.concave, "concave \n Used for background which is lower, like text field"),
        createUIView(200, 100, CustomColor.accent, "accent \n Accent color used for emphasize something"),
      ],
      spacing: 48
    )
    
    stack.configSuperView(under: scroll)
    stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

    
  }
  
  func createUIView(_ w: CGFloat,_ h:CGFloat, _ color: UIColor, _ text: String ) -> UIView {
    let uv = UIView()
    
    /*
     How to use: UIView custom configuration
     - You can configure at once by calling `configureLayout`
    */
    uv.configLayout(
      width: w,
      height: h,
      bgColor: color,
      radius: 32,
      shadow: true
    )
    
    let lb = H4Label()
    lb.textColor = .black
    lb.text = text
    lb.numberOfLines = 0
    
    let sv = VerticalStackView(arrangedSubviews: [uv, lb] ,spacing: 16)
    
    return sv
  }
  
}

