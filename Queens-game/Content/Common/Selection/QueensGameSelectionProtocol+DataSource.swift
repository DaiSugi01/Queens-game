//
//  CommonSelectionViewController+DataSource.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/05/11.
//

import UIKit


extension QueensGameSelectionProtocol {
    
  /// Configure Diffable Data source
  /// Internally, it's executing following steps
  /// 1. Reset snapshot
  /// 2. Add all items in snapshot.
  /// 3. Define cells (and headers) with data source.
  /// 4. Apply snapshot to data source.
  func configureDiffableDataSourceHelper (
    with options: [Selection],
    and title: String,
    cellProvider: @escaping (UICollectionViewDiffableDataSource<Section, Item>.CellProvider)
  ) {
    // Reset snapshot
    resetSnapshot()
    
    // Add all items in snapshot.
    snapshot.appendItems(Item.wrap(items: options), toSection: .selection)
    
    // Define cells with data source.
    dataSource = UICollectionViewDiffableDataSource<Section, Item>(
      collectionView: collectionView,
      cellProvider: cellProvider
    )
    
    // Define headers with data source.
    dataSource.supplementaryViewProvider = {
      [unowned self] (collectionView, kind, indexPath) -> UICollectionReusableView? in

      if let headerView = self.collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: GeneticLabelCollectionReusableView.identifier,
        for: indexPath
      ) as? GeneticLabelCollectionReusableView {
        
        let screenTitle: H2Label = {
          let lb = H2Label(text: title)
          lb.lineBreakMode = .byWordWrapping
          return lb
        }()
        
        headerView.configLabel(lb: screenTitle)
        return headerView
      }
      return nil
    }
    
    dataSource.apply(snapshot, animatingDifferences: false)
  }
  
  /// Delete all items of snapshot
  func resetSnapshot() {
    snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    snapshot.deleteAllItems()
    snapshot.appendSections([.selection])
  }
}

