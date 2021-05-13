//
//  TestViewController.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-12.
//

import UIKit

class TestViewController: UIViewController {
  internal init(viewModel: CommandSettingViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  let viewModel: CommandSettingViewModel
  
  let addButton: UIButton = {
    let bt = UIButton()
    bt.configLayout(width: 48, height: 48, bgColor: CustomColor.main, radius: 20)
    bt.setImage(UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate), for: .normal)
    bt.tintColor = CustomColor.background
    bt.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    return bt
  } ()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addButton.configSuperView(under: view)
    addButton.centerXYin(view)
    
  }
  
  @objc func addButtonTapped() {
    viewModel.createItem(command: Command(detail: "nnnn", difficulty: .easy, commandType: .cToA))
  }
}
