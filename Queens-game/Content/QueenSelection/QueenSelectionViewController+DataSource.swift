//
//  QueenSelectionViewController+DataSource.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/05/10.
//

import UIKit

//  Configure Diffable Data source
extension QueenSelectionViewController {
  
  /// Configure Diffable Data source
  /// Internally, it's executing following steps
  /// 1. Reset snapshot
  /// 2. Add all items in snapshot.
  /// 3. Define cells (and headers) with data source.
  /// 4. Apply snapshot to data source.
  func createDiffableDataSource(){
    registerCells()
    
    // Reset snapshot
    resetSnapshot()
    
    // Add all items in snapshot.
    snapshot.appendItems(DemoItem.wrapSelection(items: DemoSampleData.options), toSection: .selection)

    // Define cells with data source.
    dataSource = UICollectionViewDiffableDataSource<DemoSection, DemoItem>(
      collectionView: multipleSelectionCV,
      cellProvider:
        { (collectionView, indexPath, item) -> UICollectionViewCell? in
          
          if let user = item.user {
            let cell = collectionView.dequeueReusableCell(
              withReuseIdentifier: UsernameInputCollectionViewCell.identifier,
              for: indexPath
            ) as! UsernameInputCollectionViewCell
            cell.configContent(by: user.id, and: user.nickName)
            return cell
          }
          
          if let command = item.command {
            let cell = collectionView.dequeueReusableCell(
              withReuseIdentifier: CommandCollectionViewCell.identifier,
              for: indexPath
            ) as! CommandCollectionViewCell
            cell.configContent(by: command)
            return cell
          }
          
          if let selection = item.selection {
            let cell = collectionView.dequeueReusableCell(
              withReuseIdentifier: SelectionCollectionViewCell.identifier,
              for: indexPath
            ) as! SelectionCollectionViewCell
            cell.configContent(by: selection)
            return cell
          }

          return nil
        }
    )
    
    dataSource.apply(snapshot, animatingDifferences: false)
  }
  
  /// Delete all items of snapshot
  func resetSnapshot() {
    snapshot = NSDiffableDataSourceSnapshot<DemoSection, DemoItem>()
    snapshot.deleteAllItems()
    snapshot.appendSections([.userName, .command, .selection])
  }
  
  
  /// Register all cells and headers with identifier.
  private func registerCells() {
    // cell
    multipleSelectionCV.register(
      CommandCollectionViewCell.self,
      forCellWithReuseIdentifier: CommandCollectionViewCell.identifier
    )
  }
}
