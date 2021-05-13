//
//  TopViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

class TopViewController: UIViewController {
  
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
    let sv = VerticalStackView(arrangedSubviews: [startButton, editCommandButton, menuButton])
    sv.spacing = 24
    sv.alignment = .leading
    return sv
  }()
  
  let startButton = MainButton(superView: nil, title: "Start game")
  @objc func startTapped(_ sender: UIButton) {
    let nx = PlayerSelectionViewController()
    GameManager.shared.pushGameProgress(navVC: navigationController!,
                                        currentScreen: self,
                                        nextScreen: nx)
  }

<<<<<<< HEAD
  @objc func editCommand(_ sender: UIButton) {
    let nx = CommandSettingViewController()
=======
  let editCommandButton  = SubButton(superView: nil, title: "Edit commands")
  @objc func editCommandTapped(_ sender: UIButton) {
    let nx = CommandSettingViewController(collectionViewLayout: UICollectionViewFlowLayout())
>>>>>>> master
    navigationController?.pushViewController(nx, animated: true)
  }
  
  let menuButton  = SubButton(superView: nil, title: "Menu")
  @objc func goToMenu(_ sender: UIButton) {
    let nx = MenuViewController()
    navigationController?.present(nx, animated: true, completion: nil)
  }
  
  lazy var verticalSV: VerticalStackView = {
    let sv = VerticalStackView(arrangedSubviews: [screenTitle, buttonWrapper])
    sv.alignment = .fill
    sv.distribution = .equalSpacing
    sv.translatesAutoresizingMaskIntoConstraints = false
    return sv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    vm.resetGameManeger()
    setupLayout()
    setActions()
    setUpDemoButton() // debug button
  }
  
  private func setupLayout() {
    view.backgroundColor = CustomColor.background
    view.addSubview(verticalSV)
    
    // Set constraints
    verticalSV.topAnchor.constraint(equalTo: view.topAnchor,
                                     constant: Constant.Common.topSpacing).isActive = true
    verticalSV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                         constant: Constant.Common.leadingSpacing).isActive = true
    verticalSV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                          constant: Constant.Common.trailingSpacing).isActive = true
    verticalSV.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                          constant: Constant.Common.bottomSpacing).isActive = true
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
