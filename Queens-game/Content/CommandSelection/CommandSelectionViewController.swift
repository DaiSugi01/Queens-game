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

  private let viewModel = CommandSelectionViewModel()
  private let navButtons = NextAndBackButtons()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // QueensGameSelectionProtocol
    configureRegistration()
    configureViewControllerLayout()
    configureCollectionViewLayout()
    configureDiffableDataSource()
    
    // QueensGameViewControllerProtocol
    backgroundCreator.configureLayout()
    
    // navBar
    navButtons.configureSuperView(under: view)
    navButtons.configureLayoutToBottom()
    configureNavButtonBinding()
  }
}


// MARK: - QueensGameSelectionProtocol

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


// MARK: - Bindings

extension CommandSelectionViewController {
  
  private func configureNavButtonBinding() {
    
    navButtons.nextButton.rx
      .tap
      .bind { [weak self] _ in
        guard let self = self else { return }
        
        guard let index = self.collectionView.indexPathsForSelectedItems?.first?.item else { return }
        
        switch Constant.CommandSelection.Index(rawValue: index) {
        case .manual:
          let nx = CommandManualSelectingViewController()
          GameManager.shared.pushGameProgress(
            navVC: self.navigationController,
            currentScreen: self,
            nextScreen: nx
          )
        case .random:
          let nx = CitizenSelectedViewController()
          GameManager.shared.command = self.viewModel.rundomCommandSelector()
          GameManager.shared.pushGameProgress(
            navVC: self.navigationController,
            currentScreen: self,
            nextScreen: nx
          )
        default:
          print("None of them are selected")
        }
      }
      .disposed(by: viewModel.disposeBag)
    
    // Go back to previous screen
    navButtons.backButton.rx
      .tap
      .bind { [weak self] _ in
        GameManager.shared.popGameProgress(navVC: self?.navigationController)
      }
      .disposed(by: viewModel.disposeBag)
  }
  
}
