//
//  CellDemoCVC+DataSource.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-26.
//

import UIKit

//  Configure Diffable Data source
extension DemoCellCollectionViewController {
  
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
    snapshot.appendItems(DemoItem.wrapUser(items: DemoSampleData.users), toSection: .userName)
    snapshot.appendItems(DemoItem.wrapCommand(items: DemoSampleData.commands), toSection: .command)
    snapshot.appendItems(DemoItem.wrapSelection(items: DemoSampleData.options), toSection: .selection)

    // Define cells with data source.
    dataSource = UICollectionViewDiffableDataSource<DemoSection, DemoItem>(
      collectionView: collectionView,
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
      
    // Define headers with data source.
    dataSource.supplementaryViewProvider = {
      [unowned self] (collectionView, kind, indexPath) -> UICollectionReusableView? in


      if let headerView = self.collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: GeneticLabelCollectionReusableView.identifier,
        for: indexPath
      ) as? GeneticLabelCollectionReusableView {
        // Config view
        // You can set any UIlabel as Header. 
        switch self.sections[indexPath.section] {
          case .userName:
            headerView.configLabel(lb: H3Label(text: "User name input"))
          case .command:
            headerView.configLabel(lb: H3Label(text: "Command List"))
          case .selection:
            headerView.configLabel(lb: H2Label(text: "Selection"))
        }
        return headerView
      }
      return nil
    }
    
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
    collectionView.register(
      UsernameInputCollectionViewCell.self,
      forCellWithReuseIdentifier: UsernameInputCollectionViewCell.identifier
    )
    collectionView.register(
      CommandCollectionViewCell.self,
      forCellWithReuseIdentifier: CommandCollectionViewCell.identifier
    )
    collectionView.register(
      SelectionCollectionViewCell.self,
      forCellWithReuseIdentifier: SelectionCollectionViewCell.identifier
    )
    // Header
    collectionView.register(
      GeneticLabelCollectionReusableView.self,
      forSupplementaryViewOfKind: GeneticLabelCollectionReusableView.identifier,
      withReuseIdentifier: GeneticLabelCollectionReusableView.identifier
    )
  }
}
