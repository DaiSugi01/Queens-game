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
  
  // QueensGameSelectionProtocol
  var snapshot: NSDiffableDataSourceSnapshot<Section, Item>!
  var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
  var collectionView: UICollectionView! = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewLayout()
  )
  
  // QueensGameViewControllerProtocol
  lazy var backgroundCreator: BackgroundCreator = BackgroundCreatorWithMenu(viewController: self)
  
  private let navButtons = NextAndBackButtons()
  private let vm: QueenSelectionViewModel = QueenSelectionViewModel()
  
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
    
    // first aid. Fix me
    configureClosingCardBinding()
  }
}


// MARK: - QueensGameSelectionProtocol

extension QueenSelectionViewController {
  
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
}
 

// MARK: - Bindings

extension QueenSelectionViewController {
  
  private func configureNavButtonBinding() {
    navButtons.nextButton.rx
      .tap
      .bind { [weak self] _ in
        guard let self = self else { return }
        
        guard let index = self.collectionView.indexPathsForSelectedItems?.first?.item else { return }
        
        //TODO: Implements card selection later
        /// Go to next screen depends on user selection
        switch Constant.QueenSelection.Index(rawValue: index) {
        case .quick:
          self.vm.selectQueen()
          let nx = QueenSelectedViewController()
          GameManager.shared.pushGameProgress(
            navVC: self.navigationController,
            currentScreen: self,
            nextScreen: nx
          )
        case  .card:
          print("Path for card selection page")
        default:
          print("None of them are selected")
        }
      }
      .disposed(by: vm.disposeBag)
    
    // Go back to previous screen
    navButtons.backButton.rx
      .tap
      .bind { [weak self] _ in
        GameManager.shared.popGameProgress(navVC: self?.navigationController)
      }
      .disposed(by: vm.disposeBag)
  }
  
  /// FIX ME. Temporary avoid selecting card selection
  private func configureClosingCardBinding() {
    collectionView.rx
      .itemSelected
      .subscribe(onNext:{ [weak self] indexPath in
        self?.navButtons.nextButton.isEnabled =  indexPath.item != 1
        self?.navButtons.nextButton.alpha = indexPath.item != 1 ? 1 : 0.1
      })
      .disposed(by: vm.disposeBag)
  }
}
