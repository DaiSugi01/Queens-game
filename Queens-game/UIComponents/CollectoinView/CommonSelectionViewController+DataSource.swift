//
//  CommonSelectionViewController+DataSource.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/05/11.
//

import UIKit

//  Configure Diffable Data source
extension CommonSelectionViewController {
  
  /// Configure Diffable Data source
  /// Internally, it's executing following steps
  /// 1. Reset snapshot
  /// 2. Add all items in snapshot.
  /// 3. Define cells (and headers) with data source.
  /// 4. Apply snapshot to data source.
  func createDiffableDataSource(with options: [Selection]){
    registerCells()
    
    // Reset snapshot
    resetSnapshot()
    
    // Add all items in snapshot.
    snapshot.appendItems(Item.wrap(items: options), toSection: .selection)
    
    // Define cells with data source.
    dataSource = UICollectionViewDiffableDataSource<Section, Item>(
      collectionView: collectionView,
      cellProvider:
        { (collectionView, indexPath, item) -> UICollectionViewCell? in
          
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
    snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    snapshot.deleteAllItems()
    snapshot.appendSections([.selection])
  }
  
  
  /// Register all cells and headers with identifier.
  private func registerCells() {
    collectionView.register(SelectionCollectionViewCell.self, forCellWithReuseIdentifier: SelectionCollectionViewCell.identifier)
  }
}
