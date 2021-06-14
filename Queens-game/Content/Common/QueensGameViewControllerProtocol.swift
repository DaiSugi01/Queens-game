//
//  CommonViewController.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-06-09.
//

import UIKit

/// All Queens games view controller must have background view.
protocol QueensGameViewControllerProtocol where Self: UIViewController {
  var backgroundView: BackgroundView {get set}
}

//class QueensGameViewController: UIViewController {
//
//
//  let menuButton = MenuButton()
//  // List of pages to display menu button
//  let menuButtonList:[UIViewController.Type] = [
//    PlayerSelectionViewController.self,
//    EntryNameViewController.self,
//    QueenSelectionViewController.self,
//    CommandSelectionViewController.self,
//    CommandManualSelectingViewController.self,
//    ResultViewController.self
//  ]
//
//
//  // The image is expensive but same. So static.
//  static let bgImage: UIImage = {
//    let img = UIImage(named: "background-texture2")
//    return UIImage.blend(CustomColor.background, img!)
//  } ()
//  let backgroundTexture: UIImageView = {
//    let imageView = UIImageView(frame: .zero)
//    imageView.translatesAutoresizingMaskIntoConstraints = false
//    imageView.image = QueensGameBackgroundProtocol.bgImage
//    imageView.layer.cornerRadius = 12
//    imageView.layer.masksToBounds = true
//    imageView.contentMode = .scaleAspectFill
//
//    return imageView
//  } ()
//
//
//  let topLine = lineGenerator()
//  let bottomLine = lineGenerator()
//  private static func lineGenerator() -> UIView {
//    let uv = UIView()
//    uv.configLayout(height: 1, bgColor: CustomColor.subMain.withAlphaComponent(0.4))
//    return uv
//  }
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//
//    view.configBgColor(bgColor: CustomColor.concave)
//
//    configMenuButton()
//    configBorder()
//    configBackgroundImage()
//  }
//
//  private func configMenuButton() {
//    // Config position.
//    menuButton.configSuperView(under: view)
//    NSLayoutConstraint.activate([
//      menuButton.centerYAnchor.constraint(equalTo: view.topAnchor, constant: Constant.Common.topSpacing*0.5),
//      menuButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constant.Common.trailingSpacing*0.8)
//    ])
//    menuButton.addTarget(self, action: #selector(menuTapped), for: .touchUpInside)
//    menuButton.layer.zPosition = 9
//
//    // If it's in target page, display menu button
//    menuButton.isHidden = !menuButtonList.contains(where: {self.isKind(of: $0)})
//  }
//  @objc override func menuTapped() {
//    let nx = MenuViewController()
//    present(nx, animated: true, completion: nil)
//  }
//
//  private func configBorder() {
//    // Config top position.
//    topLine.configSuperView(under: view)
//    NSLayoutConstraint.activate([
//      topLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.Common.leadingSpacing),
//      topLine.centerYAnchor.constraint(equalTo: view.topAnchor, constant: Constant.Common.topSpacing*0.5)
//    ])
//    // if there is a menu button, shorten to it.
//    if menuButton.isHidden {
//      topLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constant.Common.trailingSpacing).isActive = true
//    } else {
//      topLine.trailingAnchor.constraint(equalTo: menuButton.leadingAnchor, constant: -16).isActive = true
//    }
//
//    // Config bottom position.
//    bottomLine.configSuperView(under: view)
//    NSLayoutConstraint.activate([
//      bottomLine.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -Constant.Common.leadingSpacing*2),
//      bottomLine.topAnchor.constraint(equalTo: view.bottomAnchor, constant: Constant.Common.bottomSpacing*0.5),
//      bottomLine.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//    ])
//  }
//
//  // Set bg image at the very bottom layer.
//  private func configBackgroundImage() {
//    view.insertSubview(backgroundTexture, at: 0)
//    let space: CGFloat = 0
//    backgroundTexture.matchParent(padding: .init(top: space, left: space, bottom: space, right: space))
//  }
//
//}
