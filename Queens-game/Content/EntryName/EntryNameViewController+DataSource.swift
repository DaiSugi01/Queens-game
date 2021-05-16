////
////  EntryNameViewController+DataSource.swift
////  Queens-game
////
////  Created by 杉原大貴 on 2021/05/13.
////
//
//import UIKit
//
////  Configure Diffable Data source
//extension EntryNameViewController {
//
//  /// Configure Diffable Data source
//  /// Internally, it's executing following steps
//  /// 1. Reset snapshot
//  /// 2. Add all items in snapshot.
//  /// 3. Define cells (and headers) with data source.
//  /// 4. Apply snapshot to data source.
//  func createDiffableDataSource(){
//    registerCells()
//    
//    // Reset snapshot
//    resetSnapshot()
//    
//    // Add all items in snapshot.
//    snapshot.appendItems(Item.wrap(items: GameManager.shared.users), toSection: .userName)
//
//    // Define cells with data source.
//    dataSource = UICollectionViewDiffableDataSource<Section, Item>(
//      collectionView: collectionView,
//      cellProvider:
//        { (collectionView, indexPath, item) -> UICollectionViewCell? in
//          
//          if let user = item.user {
//            let cell = collectionView.dequeueReusableCell(
//              withReuseIdentifier: UsernameInputCollectionViewCell.identifier,
//              for: indexPath
//            ) as! UsernameInputCollectionViewCell
//            cell.configContent(by: user.playerId, and: user.name)
//
//            return cell
//          }
//          
//          return nil
//        }
//    )
//    
//    dataSource.apply(snapshot, animatingDifferences: false)
//  }
//  
//  private func test(playerId: Int, text: String) {
//    GameManager.shared.users[playerId - 1].name = text
//  }
//  /// Delete all items of snapshot
//  func resetSnapshot() {
//    snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
//    snapshot.deleteAllItems()
//    snapshot.appendSections([.userName])
//  }
//  
//  
//  /// Register all cells and headers with identifier.
//  private func registerCells() {
//    collectionView.register(UsernameInputCollectionViewCell.self,
//                            forCellWithReuseIdentifier: UsernameInputCollectionViewCell.identifier)
//  }
//}
