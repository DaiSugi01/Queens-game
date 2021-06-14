//
//  TopViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

class TopViewController: UIViewController, QueensGameViewControllerProtocol {
  lazy var backgroundCreator: BackgroundCreator = BackgroundCreatorPlain(parentView: view)
  let vm = TopViewModel()
  
  let screenTitle: H1Label = {
    let lb = H1Label()
    let title = NSMutableAttributedString(string: "Queen's Game")
    title.addAttribute(.foregroundColor, value: CustomColor.accent, range: NSMakeRange(0, 1))
    lb.attributedText = title
    lb.lineBreakMode = .byWordWrapping
    lb.numberOfLines = 2
    lb.translatesAutoresizingMaskIntoConstraints = false
    return lb
  }()
  
  lazy var buttonWrapper: VerticalStackView = {
    let sv = VerticalStackView(arrangedSubviews: [startButton, editCommandButton, menuButtonAtTop])
    sv.alignment = .leading
    sv.setCustomSpacing(16, after: startButton)
    return sv
  }()
  
  let startButton = MainButton(title: "Start game")
  @objc func startTapped(_ sender: UIButton) {
    let nx = PlayerSelectionViewController()
    GameManager.shared.pushGameProgress(navVC: navigationController,
                                        currentScreen: self,
                                        nextScreen: nx)
  }
  
  let editCommandButton = SubButton(title: "Edit commands")
  @objc func editCommandTapped(_ sender: UIButton) {
    let nx = CommandSettingViewController()
    navigationController?.pushViewController(nx, animated: true)
  }
  
  let menuButtonAtTop: SubButton = SubButton(title: "Menu")
  @objc func goToMenu(_ sender: UIButton) {
    let nx = MenuViewController()
    navigationController?.present(nx, animated: true, completion: nil)
  }
  
  lazy var verticalSV: VerticalStackView = {
    let sv = VerticalStackView(arrangedSubviews: [screenTitle, buttonWrapper])
    sv.alignment = .fill
    sv.distribution = .equalSpacing
    return sv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    vm.resetGameManeger()
    backgroundCreator.configureLayout()
    setupLayout()
    setActions()
    setUpDemoButton() // debug button
  }
  
  private func setupLayout() {
    
    verticalSV.configSuperView(under: view)
    
    // Set constraints
    verticalSV.matchParent(
      padding: .init(
        top: Constant.Common.topSpacing,
        left: Constant.Common.leadingSpacing,
        bottom: -Constant.Common.bottomSpacing,
        right: -Constant.Common.trailingSpacing
      )
    )
    
  }
  
  private func setActions() {
    startButton.addTarget(self, action: #selector(startTapped(_:)), for: .touchUpInside)
    editCommandButton.addTarget(self, action: #selector(editCommandTapped(_:)), for: .touchUpInside)
    menuButtonAtTop.addTarget(self, action: #selector(goToMenu(_:)), for: .touchUpInside)
  }
}


// MARK: - Debug button

extension TopViewController {
  
  private func setUpDemoButton() {
    let demoButton = UIButton()
    
    // Set image
    let imgConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .bold, scale: .large)
    let btImage = UIImage(
      systemName: "heart.fill" ,
      withConfiguration: imgConfig
    )? // change color
    .withTintColor(CustomColor.accent, renderingMode: .alwaysOriginal)
    demoButton.setImage(btImage, for: .normal)
    // rotate image
    demoButton.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/4))
    // target
    demoButton.addTarget(self, action: #selector(demoButtonTapped(_:)), for: .touchUpInside)
    // constraint
    demoButton.configSuperView(under: view)
    demoButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 80).isActive = true
    demoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48).isActive = true
  }
  
  @objc func demoButtonTapped(_ sender: UIButton) {
    navigationController?.pushViewController(DemoViewController(), animated: true)
  }
  
}
