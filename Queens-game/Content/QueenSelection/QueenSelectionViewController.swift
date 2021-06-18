//
//  QueenSelectionViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/05/09.
//  Updated by Tak

import UIKit

class QueenSelectionViewController:
  UIViewController,
  QueensGameSelectionProtocol,
  QueensGameViewControllerProtocol
{
  var snapshot: NSDiffableDataSourceSnapshot<Section, Item>!
  
  var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
  
  var collectionView: UICollectionView! = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewLayout()
  )
  
  lazy var backgroundCreator: BackgroundCreator = BackgroundCreatorWithMenu(viewController: self)
  
  let navButtons = NextAndBackButtons()

  let vm: QueenSelectionViewModel = QueenSelectionViewModel()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureRegistration()
    configureViewControllerLayout()
    configureCollectionViewLayout()
    configureDiffableDataSource()
    
    backgroundCreator.configureLayout()
    configureButtonActions()
    
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
  
  func configureDiffableDataSource() {
    configureDiffableDataSourceHelper(
      with: Constant.QueenSelection.options,
      and: Constant.QueenSelection.title
    ) { (collectionView, indexPath, item) -> UICollectionViewCell? in
      
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

  
  /// Set Button Actions
  private func configureButtonActions() {
    navButtons.configSuperView(under: view)
    navButtons.bottomAnchor.constraint(
      equalTo: view.bottomAnchor,
      constant: -Constant.Common.bottomSpacing
    ).isActive = true
    navButtons.centerXin(view)
    
    navButtons.nextButton.addTarget(
      self,
      action: #selector(goToNext(_:)),
      for: .touchUpInside
    )
    navButtons.backButton.addTarget(
      self,
      action: #selector(goBackToPrevious(_:)),
      for: .touchUpInside
    )
  }
  
  //TODO: Implements card selection later
  /// Go to next screen depends on user selection
  /// - Parameter sender: UIButton
  @objc private func goToNext(_ sender: UIButton) {
    guard let indexPath = collectionView.indexPathsForSelectedItems else { return }
    
    switch indexPath {
    case Constant.QueenSelection.quickIndexPath:
      vm.selectQueen()
      let nx = QueenSelectedViewController()
      GameManager.shared.pushGameProgress(
        navVC: navigationController,
        currentScreen: self,
        nextScreen: nx
      )
    case  Constant.QueenSelection.cardIndexPath:
      print("Path for card selection page")
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
