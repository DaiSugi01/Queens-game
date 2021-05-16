//
//  EntryNameViewController+Layout.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/05/13.
//

import UIKit

extension EntryNameViewController {
  
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
  
  private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout(section: createSection())
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
    section.contentInsets = .init(top: 16, leading: 0, bottom: 64, trailing: 0)
    return section
  }
  
}
