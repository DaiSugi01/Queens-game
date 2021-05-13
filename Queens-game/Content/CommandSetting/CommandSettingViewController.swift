//
//  CommandSettingViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

class CommandSettingViewController: UIViewController {
  
  let viewModel = CommandSettingViewModel()
  
  //Data source
  let sections: [Section] = [.command]
  
  var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
  
  let searchBar = CustomSearchBar()
  var collectionView: UICollectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewLayout()
  )
  
  // Bottom navigation bar
  let backButton: UIButton = {
    let bt = SubButton()
    bt.configBgColor(bgColor: CustomColor.background)
    bt.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    return bt
  } ()
  let searchButton: UIButton = {
    let bt = UIButton()
    bt.configLayout(width: 48, height: 48, bgColor: CustomColor.main, radius: 20)
    bt.setImage(UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysTemplate), for: .normal)
    bt.tintColor = CustomColor.background
    bt.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    return bt
  } ()
  let addButton: UIButton = {
    let bt = UIButton()
    bt.configLayout(width: 48, height: 48, bgColor: CustomColor.main, radius: 20)
    bt.setImage(UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate), for: .normal)
    bt.tintColor = CustomColor.background
    bt.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    return bt
  } ()
  lazy var bottomNavigationBar: HorizontalStackView = {
    let sv = HorizontalStackView(
      arrangedSubviews: [backButton, searchButton, addButton],
      spacing: 56,
      alignment: .center
    )
    return sv
  } ()
  
//  init() {
//    super.init(nibName: nil, bundle: nil)
//  }
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
  
  override func viewDidLoad() {
    // Config Collection view
    createCollectionViewLayout()
    createDiffableDataSource()

    // Config Other ui views
    view.configBgColor(bgColor: CustomColor.background)
    disableDefaultNavigation()
    configSearchBar()
    configBottomNavigationBar()
    
  }
 
  @objc func backButtonTapped() {
    navigationController?.popViewController(animated: true)
  }
  @objc func addButtonTapped() {
    let nextVC = CommandEditViewController(viewModel: viewModel)
    present(nextVC, animated: true, completion: nil)
  }
  
}

extension CommandSettingViewController {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let nextVC = CommandEditViewController(viewModel: viewModel)
    nextVC.itemIndex = indexPath.row
    present(nextVC, animated: true, completion: nil)
  }
}
