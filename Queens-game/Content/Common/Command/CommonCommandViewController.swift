//
//  CommandSettingViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

class CommonCommandViewController: UIViewController, QueensGameViewControllerProtocol {
  lazy var backgroundCreator: BackgroundCreator = BackgroundCreatorPlain(parentView: view)
  
  let viewModel = CommandViewModel()
  
  //Data source
  let sections: [Section] = [.command]
  
  var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
  
  let searchBar = CustomSearchBar()
  var collectionView: UICollectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewLayout()
  )
  
  var headerTitle: String = ""
  
  // Bottom navigation bar
  let backButton: UIButton = {
    let bt = SubButton()
    bt.configBgColor(bgColor: CustomColor.background)
    bt.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
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
  
  lazy var bottomNavigationBar: HorizontalStackView = {
    let sv = HorizontalStackView(
      arrangedSubviews: [backButton, searchButton],
      spacing: 56,
      alignment: .center
    )
    return sv
  } ()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    backgroundCreator.configureLayout()
    createCollectionViewLayout()
    createDiffableDataSource()
    
    configBinding()
    
    // Config Other ui views
    disableDefaultNavigation()
    configSearchBar()
    configBottomNavigationBar()
  }
  
  @objc func backTapped() {
    navigationController?.popViewController(animated: true)
  }
  
  // Rx swift
  /// Subscriber of snapshot. This is called after snapshot in view model is modified.
  func configBinding() {
    
    viewModel.snapshotSubject
      .subscribe (onNext: { [unowned self] snapshot in
        
        var willAnimate = true
        switch viewModel.crudType {
          // If updating, false animation. This will invoke collectionView.reload and update view. Otherwise, data source won't detect any diff and stop updating.
          case .update:
            willAnimate = false
          default:
            break
        }
        
        self.dataSource.apply(snapshot, animatingDifferences: willAnimate)
      })
      .disposed(by: viewModel.disposeBag)
    
  }
  
}
