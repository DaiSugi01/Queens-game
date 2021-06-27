//
//  CommonSelectionViewController+Layout.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/05/11.
//

import UIKit


//ViewController
extension QueensGameSelectionProtocol {
  /// Setup whole layout except background.
  func configureViewControllerLayout() {
    collectionView.configSuperView(under: view)
    
    // collection view
    collectionView.matchParent(
      padding: .init(
        top: Constant.Common.topLineHeight,
        left: 0,
        bottom: Constant.Common.bottomLineHeight,
        right: 0
      )
    )
    collectionView.contentInset = .init(
      top: Constant.Common.topSpacingFromTopLine,
      left: 0,
      bottom: Constant.Common.bottomSpacingFromBottomLine,
      right: 0
    )
  }
}


// Collection View
extension QueensGameSelectionProtocol {
  
  /// Configure layout of CollectionViewController
  /// Internally, it executes
  /// 1. General layout of collection view
  /// 2. CompositionalLayout
  ///    - item
  ///    - group
  ///    - section
  ///     - with section header
  
  func configureCollectionViewLayout() {
    collectionView.configBgColor(bgColor: .clear)
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
    section.interGroupSpacing = 24
    section.contentInsets = .init(
      top: Constant.Common.topSpacingFromTitle,
      leading: Constant.Common.leadingSpacing,
      bottom: 64,
      trailing: Constant.Common.trailingSpacing
    )
    
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
