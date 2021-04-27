//
//  CommandConfirmationViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

class CommandConfirmationViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
  }
  
  let screenName: UILabel = {
    let lb = UILabel()
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.text = "Command Confirmation"
    
    return lb
  }()
  
  let confirmButton: UIButton = {
    let bt = UIButton()
    bt.translatesAutoresizingMaskIntoConstraints = false
    bt.setTitle("Yes", for: .normal)
    bt.backgroundColor = .systemRed
    bt.setTitleColor(.white, for: .normal)
    bt.addTarget(self, action: #selector(goToNext(_:)), for: .touchUpInside)
    
    return bt
  }()
  
  let cancelButton: UIButton = {
    let bt = UIButton()
    bt.translatesAutoresizingMaskIntoConstraints = false
    bt.setTitle("Cancel", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    bt.addTarget(self, action: #selector(goBack(_:)), for: .touchUpInside)
    
    return bt
  }()
  
  @objc func goToNext(_ sender: UIButton) {
    let nx = CitizenSelectingViewController()
    navigationController?.pushViewController(nx, animated: true)
  }
  
  @objc func goBack(_ sender: UIButton) {
    navigationController?.popViewController(animated: true)
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
