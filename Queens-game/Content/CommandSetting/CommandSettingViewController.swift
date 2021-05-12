//
//  CommandSettingViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

class CommandSettingViewController: UIViewController, UICollectionViewDelegate {
  
  let sections: [Section] = [.command]
  
  var snapshot: NSDiffableDataSourceSnapshot<Section, Item>!
  var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
  let searchBar = CustomSearchBar()
  var collectionView: UICollectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout()
  )
  
  let backButton: UIButton = {
    let bt = SubButton()
    bt.configBgColor(bgColor: CustomColor.background)
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
    view.configBgColor(bgColor: CustomColor.background)
    collectionView.configSuperView(under: view)
    collectionView.anchors(
      topAnchor: view.topAnchor,
      leadingAnchor: view.leadingAnchor,
      trailingAnchor: view.trailingAnchor,
      bottomAnchor: view.bottomAnchor,
      padding: .init(top: 0, left: 0, bottom: 0, right: 0)
    )
    createDiffableDataSource()
    createCollectionViewLayout()
    navigationItem.hidesBackButton = true

    
    searchBar.delegate = self
    searchBar.configSuperView(under: view)
    searchBar.anchors(
      topAnchor: view.topAnchor,
      leadingAnchor: view.leadingAnchor,
      trailingAnchor: view.trailingAnchor,
      bottomAnchor:  nil,
      padding: .init(top: 24, left: 32-8, bottom: 0, right: 32-8)
    )
    self.navigationController?.setNavigationBarHidden(true, animated: false)

    collectionView.delegate = self
    
    bottomNavigationBar.configSuperView(under: view)
    bottomNavigationBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64).isActive = true
    bottomNavigationBar.centerXin(view)
    
  }
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    
    if !decelerate {
      return
    }
    
    if(scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 0) {
        print("up")
      UIView.animate(
        withDuration: 0.24,
        delay: 0,
        options: .curveEaseIn)
      { [unowned self] in
        self.searchBar.isHidden = false
        self.searchBar.alpha = 1
      }
    }
    else {
        print("down")
      UIView.animate(
        withDuration: 0.24,
        delay: 0,
        options: .curveEaseOut)
      { [unowned self] in
        self.searchBar.alpha = 0
      } completion: { [unowned self] _ in
        self.searchBar.isHidden = true
      }
    }
  }
  
  @objc func searchButtonTapped() {
    UIView.animate(
      withDuration: 0.24,
      delay: 0,
      options: .curveEaseIn)
    { [unowned self] in
      self.searchBar.isHidden = false
      self.searchBar.alpha = 1
      searchBar.becomeFirstResponder()
    }
    
  }

}

extension CommandSettingViewController: UISearchBarDelegate {
  func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
    searchBar.setShowsCancelButton(true, animated: true)
    return true
  }
  func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
    searchBar.setShowsCancelButton(false, animated: true)
    return true
  }
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    searchBar.setShowsCancelButton(false, animated: true)
  }
}
