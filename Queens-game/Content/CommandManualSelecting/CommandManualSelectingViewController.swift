//
//  CommandManualSelectingViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit


class CommandManualSelectingViewController: CommonCommandViewController {
  
  override func viewDidLoad() {
    headerTitle = "What is your command?"
    super.viewDidLoad()
  }
  
  override func configBinding() {
    super.configBinding()
    
    // Trigger of confirm button
    viewModel.confirmedTriggerSubject.subscribe(onCompleted:{
      GameManager.shared.pushGameProgress(
        navVC: self.navigationController,
        currentScreen: self,
        nextScreen: CitizenSelectedViewController()
      )
    }).disposed(by: viewModel.disposeBag)
  }
  
  // If back is tapped
  override func backTapped() {
    guard let navVC = navigationController else { return }
    GameManager.shared.popGameProgress(navVC: navVC)
  }
  
  // If cell is tapped
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    // pass selected item's index to view model
    viewModel.updateEditMode(index: indexPath.row)
    let nx = CommandConfirmationViewController(viewModel: viewModel)
    
    present(nx, animated: true, completion: { [unowned self] in
      // If you don't set this, buttons on presented view won't respond
      self.searchBar.resignFirstResponder()
    })
  }
  
}
