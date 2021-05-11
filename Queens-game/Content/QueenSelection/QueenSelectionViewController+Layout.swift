//
//  QueenSelectionViewController+Layout.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/05/10.
//

import UIKit

extension QueenSelectionViewController {
  
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
    multipleSelectionCV.backgroundColor = CustomColor.background
    // Config compositionalLayout
    multipleSelectionCV.setCollectionViewLayout(createCompositionalLayout(), animated: false)
  }
  
  
  /// Create CompositionalLayout. It is assigning CollectionLayoutSection to each section
  /// - Returns: CompositionalLayout
  private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout
    { [unowned self] (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
      
      return createSection()
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
    
    return section
  }
  
}
