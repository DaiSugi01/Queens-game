//
//  QueenGameCollectionViewProtocal.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-06-18.
//

import UIKit

/// Rules that collection view must obey
protocol QueensGameCollectionViewProtocol where Self: UIViewController {
  var sections: [Section] { get }
  
  var snapshot: NSDiffableDataSourceSnapshot<Section, Item>! { get set }
  var dataSource: UICollectionViewDiffableDataSource<Section, Item>! { get set }
  
  var collectionView: UICollectionView! { get set }
  
  func configureRegistration()
  func configureViewControllerLayout()
  func configureCollectionViewLayout()
  func configureDiffableDataSource()
}
