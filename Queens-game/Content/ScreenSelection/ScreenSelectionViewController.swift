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
  
  private let viewModel = ScreenSelectionViewModel()
  
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
    
    configureLayout()
    configureNavButtonBinding()
  }
  
  deinit {
    print("\(Self.self) is being deinitialized")
  }
}


// MARK: - QueensGameSelectionProtocol

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



// MARK: - Layout

extension ScreenSelectionViewController {
  
  /// Set Button Actions
  private func configureLayout() {
    navButtons.configureSuperView(under: view)
    navButtons.configureLayoutToBottom()
    
    navButtons.nextButton.titleLabel?.text = "Go !"
    navButtons.nextButton.insertIcon(
      IconFactory.createSystemIcon("play.fill", color: CustomColor.background, pointSize: 16),
      to: .right
    )
  }
}


// MARK: - Bindings

extension ScreenSelectionViewController {
  
  private func configureNavButtonBinding() {
    
    navButtons.nextButton.rx
      .tap
      .bind { [weak self] _ in
        guard let self = self else { return }
        
        guard let index = self.collectionView.indexPathsForSelectedItems?.first?.item else { return }
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        guard let navigationController = self.navigationController else { return }
        
        self.viewModel.loadScreen(window, navigationController, index)
        
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
