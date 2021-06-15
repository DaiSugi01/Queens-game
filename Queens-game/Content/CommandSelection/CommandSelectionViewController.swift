//
//  CommandSelectionViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

class CommandSelectionViewController: CommonSelectionViewController,  QueensGameViewControllerProtocol {
  lazy var backgroundCreator: BackgroundCreator = BackgroundCreatorWithMenu(viewController: self)

  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    configureLayout()
    backgroundCreator.configureLayout()
    configureButtonActions()
  }
  
  /// Setup collection view layout and datasource
  private func configureCollectionView() {
    createCollectionViewLayout()
    createDiffableDataSource(
      with: Constant.CommandSelection.options,
      and: Constant.CommandSelection.title
    )
    
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
    navButtons.nextButton.addTarget(self, action: #selector(goToNext(_:)), for: .touchUpInside)
    navButtons.backButton.addTarget(self, action: #selector(goBackToPrevious(_:)), for: .touchUpInside)
  }
  
  /// Go to next screen depends on user selection
  /// - Parameter sender: UIButton
  @objc private func goToNext(_ sender: UIButton) {
    guard let indexPath = collectionView.indexPathsForSelectedItems else { return }
    
    switch indexPath {
    case Constant.CommandSelection.manualIndexPath:
        let nx = CommandManualSelectingViewController()
        GameManager.shared.pushGameProgress(navVC: navigationController,
                                            currentScreen: self,
                                            nextScreen: nx)
    case Constant.CommandSelection.randomIndexPath:
      let nx = CitizenSelectedViewController()
      GameManager.shared.pushGameProgress(navVC: navigationController,
                                          currentScreen: self,
                                          nextScreen: nx)

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
