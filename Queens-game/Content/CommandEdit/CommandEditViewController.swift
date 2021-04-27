//
//  CommandEditViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

class CommandEditViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
  }
  
  let screenName: UILabel = {
    let lb = UILabel()
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.text = "Add Edit"
    
    return lb
  }()
  
  let saveButton: UIButton = {
    let bt = UIButton()
    bt.translatesAutoresizingMaskIntoConstraints = false
    bt.setTitle("Save", for: .normal)
    bt.backgroundColor = .black
    bt.setTitleColor(.white, for: .normal)
    bt.addTarget(self, action: #selector(save(_:)), for: .touchUpInside)
    
    return bt
  }()
  
  let cancelButton: UIButton = {
    let bt = UIButton()
    bt.translatesAutoresizingMaskIntoConstraints = false
    bt.setTitle("Cancel", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    bt.addTarget(self, action: #selector(cencelTapped(_:)), for: .touchUpInside)
    
    return bt
  }()
  
  @objc func save(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
  @objc func cencelTapped(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
  private func setupLayout() {
    view.backgroundColor = .white
    navigationItem.hidesBackButton = true
    
    view.addSubview(screenName)
    view.addSubview(saveButton)
    view.addSubview(cancelButton)
    
    screenName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    screenName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
    
    saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    saveButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    
    cancelButton.trailingAnchor.constraint(equalTo: saveButton.leadingAnchor, constant: -10).isActive = true
    cancelButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }
}
