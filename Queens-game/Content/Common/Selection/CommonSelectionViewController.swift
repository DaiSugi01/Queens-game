//
//  CommonSelectionViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/05/11.
//

import UIKit

class CommonSelectionViewController: UIViewController, QueensGameViewControllerProtocol {
  lazy var backgroundView: BackgroundView = BackgroundViewWithMenu(viewController: self)
  
  let sections: [Section] = [.selection]
  
  var snapshot: NSDiffableDataSourceSnapshot<Section, Item>!
  var dataSource: UICollectionViewDiffableDataSource<Section, Item>!

  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    let collectionView = UICollectionView(
      frame: .zero,collectionViewLayout: layout
    )
    collectionView.constraintHeight(equalToConstant: 360)
    return collectionView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    backgroundView.configBackgroundLayout()
  }
}
