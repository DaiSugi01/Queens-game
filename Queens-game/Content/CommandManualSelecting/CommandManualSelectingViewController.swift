//
//  CommandManualSelectingViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit
import RxSwift
import RxCocoa


class CommandManualSelectingViewController: CommonCommandViewController {
  
  override func viewDidLoad() {
    headerTitle = "What is the queen's command?"
    super.viewDidLoad()
  }
  
  override func configSnapshotBinding() {
    super.configSnapshotBinding()
    
    // Trigger of confirm button
    viewModel.confirmedTriggerSubject.subscribe(onCompleted:{
      GameManager.shared.pushGameProgress(
        navVC: self.navigationController,
        currentScreen: self,
        nextScreen: CitizenSelectedViewController()
      )
    }).disposed(by: viewModel.disposeBag)
  }
  
  
  override func configureNavButtonBinding() {
    backButton.rx
      .tap
      .bind { [weak self] _  in
        guard let navVC = self?.navigationController else { return }
        GameManager.shared.popGameProgress(navVC: navVC)
      }
      .disposed(by: viewModel.disposeBag)
  }
  
  
  // If cell is tapped
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    // Send index of selected item to view model
    viewModel.updateEditMode(index: indexPath.row)
    
    let nx = CommandConfirmationViewController(viewModel: viewModel)
    nx.modalPresentationStyle = .automatic
    
    // After dismiss, deselect item
    viewModel.dismissSubject.subscribe { [weak self] _ in
      self?.collectionView.deselectItem(at: indexPath, animated: true)
    }
    .disposed(by: viewModel.disposeBag)
    
    present(nx, animated: true, completion: { [unowned self] in
      // If you don't set this, buttons on presented view won't respond
      self.searchBar.resignFirstResponder()
    })
  }
  
}
