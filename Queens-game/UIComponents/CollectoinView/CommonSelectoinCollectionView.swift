//
//  CommonSelectoinCollectionView.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/05/11.
//

import UIKit

class CommonSelectoinCollectionView: UICollectionView {

  let sections: [Section] = [.selection]
  
  var snapshot: NSDiffableDataSourceSnapshot<Section, Item>!
  var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
  
  init(frame: CGRect,
       collectionViewLayout layout: UICollectionViewLayout,
       with options: [Selection]) {
    super.init(frame: frame, collectionViewLayout: layout)
    createCollectionViewLayout()
    createDiffableDataSource(with: options)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
