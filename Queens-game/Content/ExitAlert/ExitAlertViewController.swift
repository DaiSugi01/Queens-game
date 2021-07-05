//
//  ExitAlertViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit
import RxSwift

class ExitAlertViewController: UIViewController {
  
  let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
    configureLayout()
    configureBinding()
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
    
    return bt
  }()
  
  let cancelButton: UIButton = {
    let bt = UIButton()
    bt.translatesAutoresizingMaskIntoConstraints = false
    bt.setTitle("No", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    
    return bt
  }()
  
  private func configureLayout() {
    view.backgroundColor = .white
    navigationItem.hidesBackButton = true

    view.addSubview(screenName)
    view.addSubview(confirmButton)
    view.addSubview(cancelButton)
    
    NSLayoutConstraint.activate([
      screenName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      screenName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      
      confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      confirmButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      
      cancelButton.trailingAnchor.constraint(equalTo: confirmButton.leadingAnchor, constant: -10),
      cancelButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
}

extension ExitAlertViewController {
  private func configureBinding() {
    confirmButton.rx
      .tap
      .bind { [weak self] _ in
        self?.dismiss(animated: true, completion: nil)
      }
      .disposed(by: disposeBag)
    
    cancelButton.rx
      .tap
      .bind { [weak self] _ in
        self?.dismiss(animated: true, completion: nil)
      }
      .disposed(by: disposeBag)
  }
}
