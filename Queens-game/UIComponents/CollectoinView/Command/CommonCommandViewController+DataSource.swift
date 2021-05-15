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
  
  /// Set subscriber
  func configBindings() {
    // What will you do at view if items have changed?
    viewModel.commandListSubject.subscribe(onNext: { [unowned self] _ in
      viewModel.updateSnapshot()
      
      var animation = true
      switch viewModel.crudType {
        // If adding item, scroll to bottom
        case .create:
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.24) {
            self.collectionView.scrollToBottom(animated: true)
          }
        // If updating, false animation. This will invoke collectionView.reload and update view. Otherwise, data source won't detect any diff and stop updating.
        case .update:
          animation = false
        default:
          break
      }
      dataSource?.apply(viewModel.snapshot, animatingDifferences: animation, completion: nil)
    }).disposed(by: viewModel.disposeBag)
    
    // What will you do at view if filtered items have changed?
    viewModel.filteredCommandListSubject.subscribe(onNext: { [unowned self] _ in
      viewModel.updateSnapshotFiltered()
      dataSource?.apply(viewModel.snapshot, animatingDifferences: true, completion: nil)
    }).disposed(by: viewModel.disposeBag)
  }
}
