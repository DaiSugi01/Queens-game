//
//  CommandSettingViewController+DataSource.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-10.
//

import UIKit

//  Configure Diffable Data source
extension CommandSettingViewController {
  
  /// temporary
  static var commands = [
    Command(
      detail: "Sing a song in front of others",
      difficulty: .hard,
      commandType: .cToA
    ),
    Command(
      detail: "Buy something worth maximum 5$ to Queen",
      difficulty: .normal,
      commandType: .cToQ
    ),
    Command(
      detail: "Look each other deeply 30secs",
      difficulty: .easy,
      commandType: .cToA
    ),
    Command(
      detail: "Sing a song in front of others",
      difficulty: .hard,
      commandType: .cToA
    ),
    Command(
      detail: "Buy something worth maximum 5$ to Queen",
      difficulty: .normal,
      commandType: .cToQ
    ),
    Command(
      detail: "Look each other deeply 30secs",
      difficulty: .easy,
      commandType: .cToA
    ),
    Command(
      detail: "Sing a song in front of others",
      difficulty: .hard,
      commandType: .cToA
    ),
    Command(
      detail: "Buy something worth maximum 5$ to Queen",
      difficulty: .normal,
      commandType: .cToQ
    ),
    Command(
      detail: "Look each other deeply 30secs",
      difficulty: .easy,
      commandType: .cToA
    ),
    Command(
      detail: "Sing a song in front of others",
      difficulty: .hard,
      commandType: .cToA
    ),
    Command(
      detail: "Buy something worth maximum 5$ to Queen",
      difficulty: .normal,
      commandType: .cToQ
    ),
    Command(
      detail: "Look each other deeply 30secs",
      difficulty: .easy,
      commandType: .cToA
    )
  ]
  
  /// Configure Diffable Data source
  /// Internally, it's executing following steps
  /// 1. Reset snapshot
  /// 2. Add all items in snapshot.
  /// 3. Define cells (and headers) with data source.
  /// 4. Apply snapshot to data source.
  func createDiffableDataSource(){
    collectionView.delegate = self
    registerCells()
    
    // Reset snapshot
    resetSnapshot()
    
    // Add all items in snapshot.
    snapshot.appendItems(
      Item.wrap(items: CommandSettingViewController.commands),
      toSection: .command
    )
    
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
    snapshot.appendSections([.command])
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
}
