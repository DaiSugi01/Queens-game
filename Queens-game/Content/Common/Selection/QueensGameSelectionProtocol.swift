//
//  CommonSelectionViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/05/11.
//
import UIKit

protocol QueensGameSelectionProtocol: QueensGameCollectionViewProtocol {
  func configureDiffableDataSourceHelper (
    with options: [Selection],
    and title: String,
    cellProvider: @escaping (UICollectionViewDiffableDataSource<Section, Item>.CellProvider)
  )
}

extension QueensGameSelectionProtocol {
  var sections: [Section] {
    [.selection]
  }
}
