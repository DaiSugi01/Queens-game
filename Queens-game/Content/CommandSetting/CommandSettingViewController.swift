//
//  CommandSettingViewController.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-12.
//

import UIKit

class CommandSettingViewController: CommonCommandViewController {
  
  let addButton: UIButton = {
    let bt = UIButton()
    bt.configLayout(width: 48, height: 48, bgColor: CustomColor.main, radius: 20)
    bt.setImage(UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate), for: .normal)
    bt.tintColor = CustomColor.background
    bt.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    return bt
  } ()
  
  override func viewDidLoad() {
    bottomNavigationBar.addArrangedSubview(addButton)
    headerTitle = "Edit commands"
    super.viewDidLoad()
  }
  
  @objc func addButtonTapped() {
    let nextVC = CommandEditViewController(viewModel: viewModel)
    viewModel.updateEditingCommand()
    present(nextVC, animated: true, completion: { [unowned self] in
      // If you don't set this, buttons on presented view won't respond
      self.searchBar.resignFirstResponder()
    })
  }
  
}

extension CommandSettingViewController {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let nextVC = CommandEditViewController(viewModel: viewModel)
    viewModel.updateEditingCommand(index: indexPath.row)
    present(nextVC, animated: true, completion: { [unowned self] in
      // If you don't set this, buttons on presented view won't respond
      self.searchBar.resignFirstResponder()
    })
  }
}
