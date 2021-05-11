//
//  TopViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

class TopViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
    setUpDemoButton() // debug button
  }
  
  let screenName: UILabel = {
    let lb = UILabel()
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.text = "Top"
    
    return lb
  }()
  
  let startGameButton: UIButton = {
    let bt = UIButton()
    bt.translatesAutoresizingMaskIntoConstraints = false
    bt.setTitle("Start game", for: .normal)
    bt.backgroundColor = .black
    bt.setTitleColor(.white, for: .normal)
    bt.addTarget(self, action: #selector(startGame(_:)), for: .touchUpInside)
    return bt
  }()

  @objc func startGame(_ sender: UIButton) {
    let nx = PlayerSelectionViewController()
    navigationController?.pushViewController(nx, animated: true)
  }
  
  let editCommandButton: UIButton = {
    let bt = UIButton()
    bt.translatesAutoresizingMaskIntoConstraints = false
    bt.setTitle("Edit commands", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    bt.addTarget(self, action: #selector(editCommand(_:)), for: .touchUpInside)
    return bt
  }()

  @objc func editCommand(_ sender: UIButton) {
    let nx = CommandSelectionViewController()
    navigationController?.pushViewController(nx, animated: true)
  }
  
  let menuButton: UIButton = {
    let bt = UIButton()
    bt.translatesAutoresizingMaskIntoConstraints = false
    bt.setTitle("Menu", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    bt.addTarget(self, action: #selector(goToMenu(_:)), for: .touchUpInside)
    return bt
  }()

  @objc func goToMenu(_ sender: UIButton) {
    let nx = MenuViewController()
    navigationController?.present(nx, animated: true, completion: nil)
  }

  private func setupLayout() {
    view.backgroundColor = .white

    view.addSubview(screenName)
    view.addSubview(startGameButton)
    view.addSubview(editCommandButton)
    view.addSubview(menuButton)

    screenName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    screenName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true

    startGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    startGameButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    
    editCommandButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    editCommandButton.topAnchor.constraint(equalTo: startGameButton.bottomAnchor, constant: 10).isActive = true

    menuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    menuButton.topAnchor.constraint(equalTo: editCommandButton.bottomAnchor, constant: 10).isActive = true
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
