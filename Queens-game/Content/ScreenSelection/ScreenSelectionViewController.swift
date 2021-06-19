//
//  ScreenSelectionViewController.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-06-18.
//

import UIKit

class ScreenSelectionViewController:
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
extension ScreenSelectionViewController {
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
      with: Constant.ScreenSelection.options,
      and: Constant.ScreenSelection.title
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
}



// Configuration for this own class
extension ScreenSelectionViewController {
  
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
    
    switch Constant.ScreenSelection.Index(rawValue: index) {
    case .home:
      let nx = CommandManualSelectingViewController()
      GameManager.shared.pushGameProgress(
        navVC: navigationController,
        currentScreen: self,
        nextScreen: nx
      )
    case .queen:
      let nx = CitizenSelectedViewController()
      GameManager.shared.pushGameProgress(
        navVC: navigationController,
        currentScreen: self,
        nextScreen: nx
      )
    case .command:
      let nx = CitizenSelectedViewController()
      GameManager.shared.pushGameProgress(
        navVC: navigationController,
        currentScreen: self,
        nextScreen: nx
      )
    case .none:
      print("no page")
    }
  }
  
  /// Go back to previous screen
  /// - Parameter sender: UIButton
  @objc private func goBackToPrevious(_ sender: UIButton) {
    GameManager.shared.popGameProgress(navVC: navigationController)
  }
}
