//
//  CommandSelectionViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

class CommandSelectionViewController:
  UIViewController,
  QueensGameSelectionProtocol,
  QueensGameViewControllerProtocol
{
  
  // QueensGameSelectionProtocol
  var snapshot: NSDiffableDataSourceSnapshot<Section, Item>!
  var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
  var collectionView: UICollectionView! = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewLayout()
  )
  
  // QueensGameViewControllerProtocol
  lazy var backgroundCreator: BackgroundCreator = BackgroundCreatorWithMenu(viewController: self)

  let navButtons = NextAndBackButtons()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // QueensGameSelectionProtocol
    configureRegistration()
    configureViewControllerLayout()
    configureCollectionViewLayout()
    configureDiffableDataSource()
    
    // QueensGameViewControllerProtocol
    backgroundCreator.configureLayout()
    
    configureButtonActions()
  }
}


// QueensGameSelectionProtocol
extension CommandSelectionViewController {
  func configureDiffableDataSource() {
    configureDiffableDataSourceHelper(
      with: Constant.CommandSelection.options,
      and: Constant.CommandSelection.title
    )  { (collectionView, indexPath, item) -> UICollectionViewCell? in
      
      if let selection = item.selection {
        let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: SelectionCollectionViewCell.identifier,
          for: indexPath
        ) as! SelectionCollectionViewCell
        cell.configContent(by: selection)

        return cell
      }
      
      return nil
    }
    
    // Select first item by default
    guard let sectionIndex = sections.firstIndex(of: .selection) else { return }
    collectionView.selectItem(
      at: IndexPath(row: 0, section: sectionIndex),
      animated: false,
      scrollPosition: .top
    )
  }
  
  func configureRegistration() {
    collectionView.register(
      SelectionCollectionViewCell.self,
      forCellWithReuseIdentifier: SelectionCollectionViewCell.identifier
    )
    
    collectionView.register(
      GeneticLabelCollectionReusableView.self,
      forSupplementaryViewOfKind: GeneticLabelCollectionReusableView.identifier,
      withReuseIdentifier: GeneticLabelCollectionReusableView.identifier
    )
  }
}

// Configuration for this own class
extension CommandSelectionViewController {
  
  /// Set Button Actions
  private func configureButtonActions() {
    navButtons.configSuperView(under: view)
    navButtons.bottomAnchor.constraint(
      equalTo: view.bottomAnchor,
      constant: -Constant.Common.bottomSpacing
    ).isActive = true
    navButtons.centerXin(view)
    
    navButtons.nextButton.addTarget(self, action: #selector(goToNext(_:)), for: .touchUpInside)
    navButtons.backButton.addTarget(self, action: #selector(goBackToPrevious(_:)), for: .touchUpInside)
  }
  
  /// Go to next screen depends on user selection
  /// - Parameter sender: UIButton
  @objc private func goToNext(_ sender: UIButton) {
    guard let index = collectionView.indexPathsForSelectedItems?.first?.item else { return }
    
    switch Constant.CommandSelection.Index(rawValue: index) {
    case .manual:
      let nx = CommandManualSelectingViewController()
      GameManager.shared.pushGameProgress(
        navVC: navigationController,
        currentScreen: self,
        nextScreen: nx
      )
    case .random:
      let nx = CitizenSelectedViewController()
      GameManager.shared.pushGameProgress(
        navVC: navigationController,
        currentScreen: self,
        nextScreen: nx
      )
    default:
      print("None of them are selected")
    }
  }
  
  /// Go back to previous screen
  /// - Parameter sender: UIButton
  @objc private func goBackToPrevious(_ sender: UIButton) {
    GameManager.shared.popGameProgress(navVC: navigationController)
  }
}
