//
//  MenuViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

class MenuViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
  }
  
  let screenName: UILabel = {
    let lb = UILabel()
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.text = "Menu"
    
    return lb
  }()
  
  let closeButton: UIButton = {
    let bt = UIButton()
    bt.translatesAutoresizingMaskIntoConstraints = false
    bt.setTitle("Close", for: .normal)
    bt.backgroundColor = .black
    bt.setTitleColor(.white, for: .normal)
    bt.addTarget(self, action: #selector(closeTapped(_:)), for: .touchUpInside)
    return bt
  }()

  @objc func closeTapped(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
  let howToPlayButton: UIButton = {
    let bt = UIButton()
    bt.translatesAutoresizingMaskIntoConstraints = false
    bt.setTitle("How to Palay", for: .normal)
    bt.backgroundColor = .black
    bt.setTitleColor(.white, for: .normal)
    bt.addTarget(self, action: #selector(howToPlaytapped(_:)), for: .touchUpInside)
    return bt
  }()

  @objc func howToPlaytapped(_ sender: UIButton) {
    let nx = RuleBookViewController()
  present(nx, animated: true, completion: nil)
  }
  
  let settingButton: UIButton = {
    let bt = UIButton()
    bt.translatesAutoresizingMaskIntoConstraints = false
    bt.setTitle("Settings", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    bt.addTarget(self, action: #selector(settingTapped(_:)), for: .touchUpInside)
    return bt
  }()

  @objc func settingTapped(_ sender: UIButton) {
    let nx = SettingsViewController()
    let navigationController = UINavigationController(rootViewController:nx)
    present(navigationController, animated: true, completion: nil)
  }
  
  let goToTopButton: UIButton = {
    let bt = UIButton()
    bt.translatesAutoresizingMaskIntoConstraints = false
    bt.setTitle("Go to Top", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    bt.addTarget(self, action: #selector(goToTop(_:)), for: .touchUpInside)
    return bt
  }()

  @objc func goToTop(_ sender: UIButton) {
    let nx = ExitAlertViewController()
    present(nx, animated: true, completion: nil)
  }

  private func setupLayout() {
    view.backgroundColor = .white
    navigationItem.hidesBackButton = true

    view.addSubview(screenName)
    view.addSubview(closeButton)
    view.addSubview(howToPlayButton)
    view.addSubview(settingButton)
    view.addSubview(goToTopButton)

    screenName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    screenName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true

    closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    closeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    
    howToPlayButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    howToPlayButton.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 10).isActive = true

    settingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    settingButton.topAnchor.constraint(equalTo: howToPlayButton.bottomAnchor, constant: 10).isActive = true

    goToTopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    goToTopButton.topAnchor.constraint(equalTo: settingButton.bottomAnchor, constant: 10).isActive = true
  }
}
