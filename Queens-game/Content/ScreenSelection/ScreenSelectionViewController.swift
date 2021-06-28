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
  
  deinit {
    print("\(Self.self) is being deinitialized")
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
    navButtons.configureLayoutToBottom()
    
    navButtons.nextButton.addTarget(self, action: #selector(goToNext(_:)), for: .touchUpInside)
    navButtons.backButton.addTarget(self, action: #selector(goBackToPrevious(_:)), for: .touchUpInside)
    
    navButtons.nextButton.titleLabel?.text = "Go !"
    navButtons.nextButton.insertIcon(
      IconFactory.createSystemIcon("play.fill", color: CustomColor.background, pointSize: 16),
      to: .right
    )
  }
  
  /// Go to next screen depends on user selection
  /// - Parameter sender: UIButton
  @objc private func goToNext(_ sender: UIButton) {
    guard let index = collectionView.indexPathsForSelectedItems?.first?.item else { return }
    
    if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
      
      let loadingView = LoadingView()
      loadingView.alpha = 0
      loadingView.frame = window.frame
      window.addSubview(loadingView)
      
      UIView.animate(withDuration: 0.24, delay: 0, options: .curveEaseInOut) {
        loadingView.alpha = 1
      } completion: { [unowned self] _ in
        
        switch Constant.ScreenSelection.Index(rawValue: index) {
          case .home:
            GameManager.shared.loadGameProgress(to: .home, with: navigationController)
          case .queen:
            GameManager.shared.loadGameProgress(to: .queenSelection, with: navigationController)
          case .command:
            GameManager.shared.loadGameProgress(to: .commandSelection, with: navigationController)
          case .none:
            print("no page")
            GameManager.shared.loadGameProgress(to: .home, with: navigationController)
        }
        
        UIView.animate(withDuration: 0.6, delay: 0, options: .beginFromCurrentState) {
          loadingView.icon.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        } completion: { _ in
          UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut) {
            loadingView.alpha = 0
          } completion: { _ in
            loadingView.removeFromSuperview()
          }
        }
      }
      
    }
  }
  
  /// Go back to previous screen
  /// - Parameter sender: UIButton
  @objc private func goBackToPrevious(_ sender: UIButton) {
    GameManager.shared.popGameProgress(navVC: navigationController)
  }
}
