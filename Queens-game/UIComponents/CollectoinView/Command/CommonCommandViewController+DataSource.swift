//
//  CommandSettingViewController+DataSource.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-10.
//

import UIKit

//  Configure Diffable Data source
extension CommonCommandViewController {

  
  /// Configure Diffable Data source
  /// Internally, it's executing following steps
  /// 1. Reset snapshot
  /// 2. Add all items in snapshot.
  /// 3. Define cells (and headers) with data source.
  /// 4. Apply snapshot to data source.
  func createDiffableDataSource(){
    collectionView.delegate = self
    registerCells()
    
    // Define cells with data source.
    dataSource = UICollectionViewDiffableDataSource<Section, Item>(
      collectionView: collectionView,
      cellProvider:
        { (collectionView, indexPath, item) -> UICollectionViewCell? in

          if let command = item.command {
            let cell = collectionView.dequeueReusableCell(
              withReuseIdentifier: CommandCollectionViewCell.identifier,
              for: indexPath
            ) as! CommandCollectionViewCell
            cell.configContent(by: command)
            return cell
          }

          return nil
        }
    )
    
    // Define headers with data source.
    dataSource.supplementaryViewProvider = {
      [unowned self] (collectionView, kind, indexPath) -> UICollectionReusableView? in
      
      if let headerView = self.collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: CommandHeaderCollectionReusableView.identifier,
        for: indexPath
      ) as? CommandHeaderCollectionReusableView {
        // Config view
        headerView.title.text = headerTitle
        return headerView
      }
      return nil
    }
    dataSource?.apply(viewModel.snapshot, animatingDifferences: false, completion: nil)
  }

  /// Register all cells and headers with identifier.
  private func registerCells() {
    // cell
    collectionView.register(
      CommandCollectionViewCell.self,
      forCellWithReuseIdentifier: CommandCollectionViewCell.identifier
    )
    
    // Header
    collectionView.register(
      CommandHeaderCollectionReusableView.self,
      forSupplementaryViewOfKind: CommandHeaderCollectionReusableView.identifier,
      withReuseIdentifier: CommandHeaderCollectionReusableView.identifier
    )
  }
  
  func configBindings() {
    viewModel.$crudType.receive(on: DispatchQueue.main)
      .sink { [unowned self] crudType in
        guard let targetCommand = viewModel.targetCommand else { return }
        
        switch crudType {
          case .create:
            viewModel.commandList.append(targetCommand)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.24) {
              self.collectionView.scrollToBottom(animated: true)
            }
          case .delete:
            viewModel.commandList.removeAll { $0.id == targetCommand.id }
          case .update:
            if let index = viewModel.commandList.firstIndex(where: { $0.id == targetCommand.id }) {
              viewModel.commandList[index] = targetCommand
            }
        }
        viewModel.updateSnapshot()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.24) {
          dataSource?.apply(viewModel.snapshot, animatingDifferences: true, completion: nil)
        }

      }
      // Keep cancelables
      .store(in: &viewModel.cancellables)
    
  }
}
