//
//  DefaultBackground.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-06-12.
//

import UIKit


/// BackgroundView used for all Queen's game screen.
protocol BackgroundView where Self: UIView{
  func configBackgroundLayout()
}


/// Basic background view component.
/// This component includes
/// - background image (paper like texture)
/// - top border
/// - bottom border
class BackgroundViewPlain: UIView, BackgroundView {
  
  weak var parentView: UIView!

  let topLine = lineGenerator()
  let bottomLine = lineGenerator()
  let backgroundView: UIImageView = {
    let imgv = UIImageView()
    imgv.translatesAutoresizingMaskIntoConstraints = false
    imgv.image = BackgroundViewPlain.bgImage
    imgv.layer.cornerRadius = 12
    imgv.layer.masksToBounds = true
    imgv.contentMode = .scaleAspectFill
    return imgv
  } ()
  
  init(parentView: UIView) {
    super.init(frame: .zero)
    self.parentView = parentView
  }
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configBackgroundLayout() {
    self.configSuperView(under: parentView)
    self.matchParent()
    configBackgroundImage()
    configBorder()
  }
  
  func configBorder() {
    // Config top position.
    topLine.configSuperView(under: self)
    NSLayoutConstraint.activate([
      topLine.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constant.Common.leadingSpacing),
      topLine.centerYAnchor.constraint(equalTo: self.topAnchor, constant: Constant.Common.topSpacing*0.5),
      topLine.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constant.Common.trailingSpacing)
    ])
    
    // Config bottom position.
    bottomLine.configSuperView(under: self)
    NSLayoutConstraint.activate([
      bottomLine.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -Constant.Common.leadingSpacing*2),
      bottomLine.topAnchor.constraint(equalTo: self.bottomAnchor, constant: Constant.Common.bottomSpacing*0.5),
      bottomLine.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    ])
  }
  
  // Set bg image at the very bottom layer.
  func configBackgroundImage() {
    parentView.insertSubview(backgroundView, at: 0)
    let space: CGFloat = 0
    backgroundView.matchParent(padding: .init(top: space, left: space, bottom: space, right: space))
  }
  
  static func lineGenerator() -> UIView {
    let uv = UIView()
    uv.configLayout(height: 1, bgColor: CustomColor.subMain.withAlphaComponent(0.4))
    return uv
  }
  static let bgImage: UIImage = {
    let img = UIImage(named: "background-texture2")
    return UIImage.blend(CustomColor.background, img!)
  } ()

}
