//
//  CellDemoCollectionViewController.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-26.
//

import UIKit


/// ⚠️ This is a demo ViewController. Do not use this class in release version.
///
/// This ViewController demonstrates how to use each cells with "diffable data source" and "collection view compositional layout."
/// This controller shows the usage of
/// 1. CommandCollectionViewCell
/// 2. UsernameInputCollectionViewCell
/// 3. SelectionCollectionViewCell
/// 4. GeneticLabelCollectionReusableView (Custom Header view)
/// - with  "diffable data source"
/// - with "collection view compositional layout."
/// - with considering multiple sections
class DemoCellCollectionViewController: UICollectionViewController {

  let sections: [DemoSection] = [.userName, .command, .selection]
  
  var snapshot: NSDiffableDataSourceSnapshot<DemoSection, DemoItem>!
  var dataSource: UICollectionViewDiffableDataSource<DemoSection, DemoItem>!
  
  init() {
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
    createCollectionViewLayout()
    createDiffableDataSource()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


