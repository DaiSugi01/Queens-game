//
//  ExitAlertViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

class ExitAlertViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
  }
  
  let screenName: UILabel = {
    let lb = UILabel()
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.text = "Exit Alert"
    
    return lb
  }()
  
  let confirmButton: UIButton = {
    let bt = UIButton()
    bt.translatesAutoresizingMaskIntoConstraints = false
    bt.setTitle("Yes", for: .normal)
    bt.backgroundColor = .systemRed
    bt.setTitleColor(.white, for: .normal)
    bt.addTarget(self, action: #selector(confirmTapped(_:)), for: .touchUpInside)
    
    return bt
  }()
  
  let cancelButton: UIButton = {
    let bt = UIButton()
    bt.translatesAutoresizingMaskIntoConstraints = false
    bt.setTitle("No", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    bt.addTarget(self, action: #selector(exit(_:)), for: .touchUpInside)
    
    return bt
  }()
  
  @objc func confirmTapped(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
  @objc func exit(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
  private func setupLayout() {
    view.backgroundColor = .white
    navigationItem.hidesBackButton = true

    view.addSubview(screenName)
    view.addSubview(confirmButton)
    view.addSubview(cancelButton)
    
    screenName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    screenName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
    
    confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    confirmButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    
    cancelButton.trailingAnchor.constraint(equalTo: confirmButton.leadingAnchor, constant: -10).isActive = true
    cancelButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }
}
