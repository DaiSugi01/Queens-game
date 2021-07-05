//
//  CommandSettingViewController+Layout.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-10.
//

import UIKit


extension CommonCommandViewController {
  func configureSearchBar() {
    searchBar.delegate = self
    // Position
    searchBarMask.configureSuperView(under: view)
    searchBar.configureSuperView(under: view)
    searchBar.anchors(
      topAnchor: nil,
      leadingAnchor: view.leadingAnchor,
      trailingAnchor: view.trailingAnchor,
      bottomAnchor:  nil,
      padding: .init(
        top: 0 ,
        left: Constant.Common.leadingSpacing - 10,
        bottom: 0,
        right: Constant.Common.trailingSpacing - 10
      )
    )
    // Set search bar same height as topLine of background
    if let background = backgroundCreator as? BackgroundCreatorPlain {
      searchBar.centerYAnchor.constraint(
        greaterThanOrEqualTo: background.topLine.centerYAnchor
      ).isActive = true
    }
    searchBar.isHidden = true
    
    // Mask
    searchBarMask.configureBgColor(bgColor: CustomColor.background.resolvedColor(with: .init(userInterfaceStyle: .dark)))
    searchBarMask.alpha = 0
    searchBarMask.matchParent()
    
    let tapGesture = UITapGestureRecognizer()
    searchBarMask.addGestureRecognizer(tapGesture)
    tapGesture.rx.event.bind { [weak self] _ in
      self?.searchBar.endEditing(true)
    }
    .disposed(by: viewModel.disposeBag)

  }
  
  func configureBottomNavigationBar() {
    bottomNavigationBar.configureSuperView(under: view)
    bottomNavigationBar.bottomAnchor.constraint(
      equalTo: view.bottomAnchor,
      constant: -Constant.Common.bottomSpacing
    ).isActive = true
    bottomNavigationBar.centerXin(view)
  }
}

extension CommonCommandViewController {
  /// Configure layout of CollectionViewController
  /// Internally, it executes
  /// 1. General layout of collection view
  /// 2. CompositionalLayout
  ///    - item
  ///    - group
  ///    - section
  ///     - with section header
  func createCollectionViewLayout() {
    collectionView.configureLayout(superView: view, bgColor: .clear)
    collectionView.anchors(
      topAnchor: view.topAnchor,
      leadingAnchor: view.leadingAnchor,
      trailingAnchor: view.trailingAnchor,
      bottomAnchor: view.bottomAnchor,
      padding: .init(
        top: Constant.Common.topLineHeight,
        left: 0,
        bottom: Constant.Common.bottomLineHeight,
        right: 0
      )
    )
    
    // Config compositionalLayout
    collectionView.setCollectionViewLayout(createCompositionalLayout(), animated: false)
    collectionView.contentInset = .init(
      top: Constant.Common.topSpacingFromTopLine,
      left: 0,
      bottom: Constant.Common.bottomSpacingFromBottomLine,
      right: 0
    )
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
    section.contentInsets = .init(
      top: 24, // This space is between header view and section. We can't set space with this. This. Thus, For Top space, we set it by collectionView.contentInsets.
      leading: Constant.Common.leadingSpacing,
      bottom: Constant.Common.bottomSpacing,
      trailing: Constant.Common.trailingSpacing
    )
    
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
