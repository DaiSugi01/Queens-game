//
//  SettingsViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

class SettingsViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
  }
  
  let screenName: UILabel = {
    let lb = UILabel()
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.text = "Settings"
    
    return lb
  }()
  
  let closeButton: UIButton = {
    let bt = UIButton()
    bt.translatesAutoresizingMaskIntoConstraints = false
    bt.setTitle("Close", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    bt.addTarget(self, action: #selector(closeTapped(_:)), for: .touchUpInside)
    
    return bt
  }()
  
  @objc func closeTapped(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
  private func setupLayout() {
    view.backgroundColor = .white
    navigationItem.hidesBackButton = true
    
    view.addSubview(screenName)
    view.addSubview(closeButton)
    
    screenName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    screenName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
    
    closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    closeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }
}
