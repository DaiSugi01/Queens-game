//
//  CommandManualSelectingViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

private let reuseIdentifier = "Cell"

class CommandManualSelectingViewController: CommonCommandViewController {
  
  override func viewDidLoad() {
    headerTitle = "What is your command?"
    super.viewDidLoad()
  }
  
}

// Delegate
extension CommandManualSelectingViewController {
  // If cell is tapped
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let nx = CommandConfirmationViewController(viewModel: viewModel)
    viewModel.updateEditingCommand(index: indexPath.row)
    present(nx, animated: true, completion: nil)
  }
}
