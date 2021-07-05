//
//  CommandSettingViewController.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-12.
//

import UIKit
import RxSwift

class CommandSettingViewController: CommonCommandViewController {
  
  let addButton: QueensGameButton = {
    let bt = QueensGameButton()
    bt.configureLayout(width: 48, height: 48, bgColor: CustomColor.text, radius: 20)
    bt.setImage(
      IconFactory.createSystemIcon(
        "plus",
        color: CustomColor.background,
        pointSize: 14
      ),
      for: .normal
    )
    return bt
  } ()
  
  override func viewDidLoad() {
    bottomNavigationBar.addArrangedSubview(addButton)
    headerTitle = "Edit commands"
    super.viewDidLoad()
    
    configureBinding()
  }
  
}

extension CommandSettingViewController {
  // If cell is tapped
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let nextVC = CommandEditViewController(viewModel: viewModel)
    
    viewModel.dismissSubject.subscribe { [weak self] _ in
      self?.collectionView.deselectItem(at: indexPath, animated: true)
    }
    .disposed(by: viewModel.disposeBag)
    
    // Pass selected command's position(index) to view model.
    viewModel.updateEditMode(index: indexPath.row)
    present(nextVC, animated: true, completion: { [unowned self] in
      // If you don't set this, buttons on presented view won't respond
      self.searchBar.resignFirstResponder()
    })
  }
  
}

extension CommandSettingViewController {
  
  private func configureBinding() {
    
    // If #item reach max, disable add button.
    viewModel.didReachMaxItemRelay
      .map(!)
      .bind(to: addButton.rx.isValid)
      .disposed(by: viewModel.disposeBag)
    
    addButton.rx
      .tap
      .bind { [weak self] _ in
        guard let self = self else { return }
        let nextVC = CommandEditViewController(viewModel: self.viewModel)
        // Pass no editing command == create item.
        self.viewModel.updateEditMode()
        self.present(nextVC, animated: true, completion: { [weak self] in
          // If you don't set this, buttons on presented view won't respond
          self?.searchBar.resignFirstResponder()
        })
      }
      .disposed(by: viewModel.disposeBag)
  }
}
