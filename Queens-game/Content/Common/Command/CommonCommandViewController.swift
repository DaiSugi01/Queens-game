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
  let searchBarMask = UIView()
  
  var collectionView: UICollectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewLayout()
  )
  
  var headerTitle: String = ""
  
  // Bottom navigation bar
  let backButton = SubButton()
  
  let searchButton: QueensGameButton = {
    let bt = QueensGameButton()
    bt.configureLayout(width: 48, height: 48, bgColor: CustomColor.text, radius: 20)
    bt.setImage(
      IconFactory.createSystemIcon(
        "magnifyingglass",
        color: CustomColor.background,
        pointSize: 14
      ),
      for: .normal
    )
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
    
    configSnapshotBinding()
    configureNavButtonBinding()
    configureSearchButtonBinding()
    
    // Config Other ui views
    configureSearchBar()
    configureBottomNavigationBar()
  }
  
  
  /// Subscriber of snapshot. This is called after snapshot in view model is modified.
  func configSnapshotBinding() {
    
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
  
  func configureNavButtonBinding() {
    backButton.rx
      .tap
      .bind { [weak self] _  in
        self?.navigationController?.popViewController(animated: true)
      }
      .disposed(by: viewModel.disposeBag)
  }
}

