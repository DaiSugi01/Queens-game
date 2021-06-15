//
//  CommandSettingViewController+Layout.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-10.
//

import UIKit


extension CommonCommandViewController {
  func configSearchBar() {
    searchBar.delegate = self
    searchBar.configSuperView(under: view)
    searchBar.anchors(
      topAnchor: view.topAnchor,
      leadingAnchor: view.leadingAnchor,
      trailingAnchor: view.trailingAnchor,
      bottomAnchor:  nil,
      padding: .init(top: Constant.Common.topSpacing*0.64 - 24, left: 32-8, bottom: 0, right: 32-8)
    )
    searchBar.isHidden = true
  }
  
  func configBottomNavigationBar() {
    bottomNavigationBar.configSuperView(under: view)
    bottomNavigationBar.bottomAnchor.constraint(
      equalTo: view.bottomAnchor,
      constant: -Constant.Common.bottomSpacing
    ).isActive = true
    bottomNavigationBar.centerXin(view)
  }
  
  func disableDefaultNavigation() {
    navigationItem.hidesBackButton = true
    navigationController?.setNavigationBarHidden(true, animated: false)
  }
}

extension CommonCommandViewController {
  /// Config layout of CollectionViewController
  /// Internally, it executes
  /// 1. General layout of collection view
  /// 2. CompositionalLayout
  ///    - item
  ///    - group
  ///    - section
  ///     - with section header
  func createCollectionViewLayout() {
    collectionView.configLayout(superView: view, bgColor: .clear)
    collectionView.anchors(
      topAnchor: view.topAnchor,
      leadingAnchor: view.leadingAnchor,
      trailingAnchor: view.trailingAnchor,
      bottomAnchor: view.bottomAnchor,
      padding: .init(top: 0, left: 0, bottom: 0, right: 0)
    )
    
    // Config compositionalLayout
    collectionView.setCollectionViewLayout(createCompositionalLayout(), animated: false)
  }
  
  
  /// Create CompositionalLayout. It is assigning CollectionLayoutSection to each section
  /// - Returns: CompositionalLayout
  private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout(section: createSection())
  }
  
  /// Create layout of section. You can create different layout of section by modifying or duplicating this function.
  /// - Returns: NSCollectionLayoutSection
  private func createSection() -> NSCollectionLayoutSection {
    
    // Item
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .estimated(80)
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
    section.contentInsets = .init(top: 16, leading: 32, bottom: 128, trailing: 32)
    
    // Header view of section
    section.boundarySupplementaryItems = [createHeader(CommandHeaderCollectionReusableView.identifier)]
    
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
      heightDimension: .estimated(160)
    )
    let header = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: headerSize,
      elementKind: kindOf,
      alignment: .top // .top isHeader. .bottom is Footer
    )
    return header
  }
  
}
