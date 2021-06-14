//
//  DefaultBackground.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-06-12.
//

import UIKit


/// This will set up background. This is used for all Queen's game screen.
protocol BackgroundCreator {
  func configureLayout()
}


/// Basic background component.
/// This component includes
/// - background image (paper like texture)
/// - top border
/// - bottom border
class BackgroundCreatorPlain: BackgroundCreator {
  
  weak var parentView: UIView!

  let topLine = lineGenerator()
  let bottomLine = lineGenerator()
  let backgroundView: UIImageView = {
    let imgv = UIImageView()
    imgv.translatesAutoresizingMaskIntoConstraints = false
    imgv.image = BackgroundCreatorPlain.bgImage
    imgv.layer.masksToBounds = true
    imgv.contentMode = .scaleAspectFill
    return imgv
  } ()
  
  init(parentView: UIView) {
    self.parentView = parentView
  }
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureLayout() {
    configureSuperView()
    configureBackgroundImage()
    configureBorder()
  }
  
  func configureSuperView() {
    parentView.insertSubview(backgroundView, at: 0)
    topLine.configSuperView(under: parentView)
    bottomLine.configSuperView(under: parentView)
  }
  
  func configureBorder() {
    // Top border
    NSLayoutConstraint.activate([
      topLine.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: Constant.Common.leadingSpacing),
      topLine.centerYAnchor.constraint(equalTo: parentView.topAnchor, constant: Constant.Common.topSpacing*0.5),
      topLine.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: Constant.Common.trailingSpacing)
    ])
    
    // Bottom
    NSLayoutConstraint.activate([
      bottomLine.widthAnchor.constraint(equalTo: parentView.widthAnchor, constant: -Constant.Common.leadingSpacing*2),
      bottomLine.topAnchor.constraint(equalTo: parentView.bottomAnchor, constant: Constant.Common.bottomSpacing*0.5),
      bottomLine.centerXAnchor.constraint(equalTo: parentView.centerXAnchor)
    ])
  }
  
  // Set bg image at the very bottom layer.
  private func configureBackgroundImage() {
    let space: CGFloat = 0
    backgroundView.matchParent(padding: .init(top: space, left: space, bottom: space, right: space))
  }
  
  private static func lineGenerator() -> UIView {
    let uv = UIView()
    uv.configLayout(height: 1, bgColor: CustomColor.subMain.withAlphaComponent(0.4))
    return uv
  }
  private  static let bgImage: UIImage = {
    let img = UIImage(named: "background-texture2")
    return UIImage.blend(CustomColor.background, img!)
  } ()

}
