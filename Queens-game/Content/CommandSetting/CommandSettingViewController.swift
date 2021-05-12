//
//  CommandSettingViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

class CommandSettingViewController: UIViewController {
  
  //Data source
  let sections: [Section] = [.command]
  var snapshot: NSDiffableDataSourceSnapshot<Section, Item>!
  var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
  
  let searchBar = CustomSearchBar()
  var collectionView: UICollectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout()
  )
  
  // Bottom navigation bar
  let backButton: UIButton = {
    let bt = SubButton()
    bt.configBgColor(bgColor: CustomColor.background)
    bt.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    return bt
  } ()
  let searchIcon: UIButton = {
    let bt = UIButton()
    bt.configLayout(width: 40, height: 40, bgColor: CustomColor.main, radius: 20)
    bt.setImage(UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysTemplate), for: .normal)
    bt.tintColor = CustomColor.background
    bt.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    return bt
  } ()
  lazy var bottomNavigationBar: HorizontalStackView = {
    let sv = HorizontalStackView(
      arrangedSubviews: [backButton, searchIcon],
      spacing: 64,
      alignment: .center
    )
    return sv
  } ()
  
  override func viewDidLoad() {
    // Config Collection view
    createDiffableDataSource()
    createCollectionViewLayout()
    
    // Config Other ui views
    view.configBgColor(bgColor: CustomColor.background)
    disableDefaultNavigation()
    configSearchBar()
    configBottomNavigationBar()
  }
 
  @objc func backButtonTapped() {
    navigationController?.popViewController(animated: true)
  }
  
}
