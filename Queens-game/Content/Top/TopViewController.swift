//
//  TopViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

class TopViewController: UIViewController {
  
  let gameTitle: H1Label = {
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
    let sv = VerticalStackView(arrangedSubviews: [startButton, editCommandButton, menuButton])
    sv.spacing = 24
    sv.alignment = .leading
    return sv
  }()
  
  let startButton = MainButton(superView: nil, title: "Start game")
  @objc func startTapped(_ sender: UIButton) {
    let nx = PlayerSelectionViewController()
    navigationController?.pushViewController(nx, animated: true)
  }

  let editCommandButton  = SubButton(superView: nil, title: "Edit commands")
  @objc func editCommandTapped(_ sender: UIButton) {
    let nx = CommandSettingViewController(collectionViewLayout: UICollectionViewFlowLayout())
    navigationController?.pushViewController(nx, animated: true)
  }
  
  let menuButton  = SubButton(superView: nil, title: "Menu")
  @objc func goToMenu(_ sender: UIButton) {
    let nx = MenuViewController()
    navigationController?.present(nx, animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpDemoButton() // debug button
    setupLayout()
    setActions()
  }

  private func setupLayout() {
    view.backgroundColor = CustomColor.background
    view.addSubview(gameTitle)
    view.addSubview(buttonWrapper)
    
    gameTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 128).isActive = true
    gameTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
    gameTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32).isActive = true
    buttonWrapper.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 35).isActive = true
    buttonWrapper.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -64).isActive = true
  }
  
  private func setActions() {
    startButton.addTarget(self, action: #selector(startTapped(_:)), for: .touchUpInside)
    editCommandButton.addTarget(self, action: #selector(editCommandTapped(_:)), for: .touchUpInside)
    menuButton.addTarget(self, action: #selector(goToMenu(_:)), for: .touchUpInside)
  }
}


// MARK: - Debug button

extension TopViewController {
    
  private func setUpDemoButton() {
    let demoButton = UIBarButtonItem(systemItem: .organize)
    demoButton.action = #selector(demoButtonTapped(_:))
    demoButton.target = self
    demoButton.tintColor = .black
    navigationItem.leftBarButtonItems = [demoButton]
  }
  
  @objc func demoButtonTapped(_ sender: UIButton) {
    navigationController?.pushViewController(DemoViewController(), animated: true)
  }

}
