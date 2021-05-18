//
//  CommandSelectionViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

class CommandSelectionViewController: CommonSelectionViewController {
  
  let screenTitle: H2Label = {
    let lb = H2Label(text: "How do you make your command?")
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.lineBreakMode = .byWordWrapping
    lb.numberOfLines = 0
    lb.setContentHuggingPriority(.required, for: .vertical)
    return lb
  }()
  
  let navButtons = NextAndBackButtons()
  
  lazy var verticalSV: VerticalStackView = {
    let sv = VerticalStackView(arrangedSubviews: [screenTitle, collectionView])
    sv.alignment = .fill
    sv.distribution = .equalSpacing
    sv.translatesAutoresizingMaskIntoConstraints = false
    return sv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    setupLayout()
    setButtonActions()
  }
  
  /// Setup collection view layout and datasource
  private func setupCollectionView() {
    createCollectionViewLayout()
    createDiffableDataSource(with: Constant.CommandSelection.options)
  }
  
  /// Setup whole layout
  private func setupLayout() {
    // config navigation
    navigationItem.hidesBackButton = true
    
    // add components to super view
    view.backgroundColor = CustomColor.background
    view.addSubview(verticalSV)
    view.addSubview(navButtons)

    // set constraints
    verticalSV.topAnchor.constraint(equalTo: view.topAnchor,
                                    constant: Constant.Common.topSpacing).isActive = true
    verticalSV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                        constant: Constant.Common.leadingSpacing).isActive = true
    verticalSV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                         constant:  Constant.Common.trailingSpacing).isActive = true
    
    navButtons.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                       constant: Constant.Common.bottomSpacing).isActive = true
    navButtons.centerXin(view)
  }
  
  /// Set Button Actions
  private func setButtonActions() {
    navButtons.nextButton.addTarget(self, action: #selector(goToNext(_:)), for: .touchUpInside)
    navButtons.backButton.addTarget(self, action: #selector(goBackToPrevious(_:)), for: .touchUpInside)
  }
  
  /// Go to next screen depends on user selection
  /// - Parameter sender: UIButton
  @objc private func goToNext(_ sender: UIButton) {
    guard let indexPath = collectionView.indexPathsForSelectedItems else { return }
    
    switch indexPath {
    case Constant.CommandSelection.randomIndexPath:
      let nx = QueenSelectedViewController()
      GameManager.shared.pushGameProgress(navVC: navigationController,
                                          currentScreen: self,
                                          nextScreen: nx)
    case Constant.CommandSelection.manualIndexPath:
      let nx = CommandManualSelectingViewController(collectionViewLayout: UICollectionViewFlowLayout())
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
