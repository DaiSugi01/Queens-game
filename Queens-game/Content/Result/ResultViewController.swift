//
//  ResultViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

class ResultViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
  }
  
  let screenName: UILabel = {
    let lb = UILabel()
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.text = "Result"
    
    return lb
  }()
  
  let playAgainButton: UIButton = {
    let bt = UIButton()
    bt.translatesAutoresizingMaskIntoConstraints = false
    bt.setTitle("Play again", for: .normal)
    bt.backgroundColor = .black
    bt.setTitleColor(.white, for: .normal)
    bt.addTarget(self, action: #selector(goToNext(_:)), for: .touchUpInside)
    
    return bt
  }()
  
  let backToTopButton: UIButton = {
    let bt = UIButton()
    bt.translatesAutoresizingMaskIntoConstraints = false
    bt.setTitle("Back to start menu", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    bt.addTarget(self, action: #selector(goBack(_:)), for: .touchUpInside)
    
    return bt
  }()
  
  @objc func goToNext(_ sender: UIButton) {
    let previous = navigationController!.viewControllers[1]
    navigationController?.popToViewController(previous, animated: true)
  }
  
  @objc func goBack(_ sender: UIButton) {
    navigationController?.popToRootViewController(animated: true)
  }
  
  private func setupLayout() {
    view.backgroundColor = .white
    navigationItem.hidesBackButton = true

    view.addSubview(screenName)
    view.addSubview(playAgainButton)
    view.addSubview(backToTopButton)
    
    screenName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    screenName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
    
    playAgainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    playAgainButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    
    backToTopButton.trailingAnchor.constraint(equalTo: playAgainButton.leadingAnchor, constant: -10).isActive = true
    backToTopButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }
}
