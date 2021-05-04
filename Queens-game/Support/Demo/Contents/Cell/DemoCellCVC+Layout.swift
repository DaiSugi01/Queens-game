//
//  DemoCellCVC+Layout.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-27.
//

import UIKit

// Config layout of CollectionViewController
extension DemoCellCollectionViewController {
 
  
  /// Config layout of CollectionViewController
  /// Internally, it executes
  /// 1. General layout of collection view
  /// 2. CompositionalLayout
  ///    - item
  ///    - group
  ///    - section
  ///     - with section header
  func createCollectionViewLayout() {
    view.backgroundColor = CustomColor.background
    collectionView.backgroundColor = CustomColor.background
    // Config compositionalLayout
    collectionView.setCollectionViewLayout(createCompositionalLayout(), animated: false)
  }
  
  
  /// Create CompositionalLayout. It is assigning CollectionLayoutSection to each section
  /// - Returns: CompositionalLayout
  private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout
    { [unowned self] (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
      
      // Assigning layout of section to each section
      // You can create different layout of section by modifying or duplicating `createSection()`
      switch self.sections[sectionIndex] {
        case .userName:
          return createSection()
        case .command:
          return createSection()
        case .selection:
          return createSection()
      }
    }
  }
  
  
  /// Create layout of section. You can create different layout of section by modifying or duplicating this function.
  /// - Returns: NSCollectionLayoutSection
  private func createSection() -> NSCollectionLayoutSection {
    
    // Item
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .estimated(160)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    // Group
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: itemSize.heightDimension
    )
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitem: item,
      count: 1
    )
 
    // Section
    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = 16
    section.contentInsets = .init(top: 16, leading: 32, bottom: 64, trailing: 32)
    // Header view of section
    section.boundarySupplementaryItems = [createHeader(GeneticLabelCollectionReusableView.identifier)]
    
    return section
  }
  
  /// Create section header for section
  /// - Parameter kindOf: I think you can use same identifier... ?
  /// - Returns: Header
  private func createHeader(
    _ kindOf: String = ""
  ) -> NSCollectionLayoutBoundarySupplementaryItem {
    
    let headerSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .estimated(40)
    )
    let header = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: headerSize,
      elementKind: kindOf,
      alignment: .top // .top isHeader. .bottom is Footer
    )
    return header
  }

}
