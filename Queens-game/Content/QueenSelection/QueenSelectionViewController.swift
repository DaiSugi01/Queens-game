//
//  QueenSelectionViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/05/09.
//

import UIKit

class QueenSelectionViewController: UIViewController, UICollectionViewDelegate {

  let sections: [Section] = [.selection]

  var snapshot: NSDiffableDataSourceSnapshot<DemoSection, DemoItem>!
  var dataSource: UICollectionViewDiffableDataSource<DemoSection, DemoItem>!
  
  let screenTitle: H2Label = {
    let lb = H2Label(text: "Let's decide the Queen")
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.lineBreakMode = .byWordWrapping
    lb.numberOfLines = 2
    lb.textAlignment = .left
    return lb
  }()
  
  let multipleSelectionCV: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    let collectionView = UICollectionView(
      frame: .zero,collectionViewLayout: layout
    )
    return collectionView
  }()
  
  let navButtons = NextAndBackButtons()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    setupLayout()
    setButtonActions()
  }
  
  private func setupCollectionView() {
    createCollectionViewLayout()
    createDiffableDataSource()
  }
  
  private func setupLayout() {
    navigationItem.hidesBackButton = true
    view.backgroundColor = CustomColor.background
    
    let verticalSV = VerticalStackView(arrangedSubviews: [screenTitle, multipleSelectionCV, navButtons])
    verticalSV.alignment = .fill
    verticalSV.distribution = .fill
    verticalSV.spacing = 40
    verticalSV.translatesAutoresizingMaskIntoConstraints = false
    verticalSV.distribution = .equalSpacing
    view.addSubview(verticalSV)
    verticalSV.matchParent(padding: .init(top: 64, left: 32, bottom: 64, right: 32))
  }
  
  private func setButtonActions() {
    navButtons.nextButton.addTarget(self, action: #selector(goToNext(_:)), for: .touchUpInside)
    navButtons.backButton.addTarget(self, action: #selector(goBackToPrevious(_:)), for: .touchUpInside)
  }
  
  @objc private func goToNext(_ sender: UIButton) {
    let nx = QueenSelectedViewController()
    navigationController?.pushViewController(nx, animated: true)
  }
  
  @objc private func goBackToPrevious(_ sender: UIButton) {
    navigationController?.popViewController(animated: true)
  }
  
  private func generateLayout() -> UICollectionViewLayout {
    return UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      
      // Item
      let itemSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .estimated(160)
      )
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
      // Group
      let groupSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: itemSize.heightDimension
      )
      let group = NSCollectionLayoutGroup.horizontal(
        layoutSize: groupSize,
        subitem: item,
        count: 1
      )
   
      // Section
      let section = NSCollectionLayoutSection(group: group)
      section.interGroupSpacing = 16
      section.contentInsets = .init(top: 16, leading: 32, bottom: 64, trailing: 32)
      
      return section
    }
  }
  
  private func createDataSource() {
    dataSource = UICollectionViewDiffableDataSource<DemoSection, DemoItem>(collectionView: self.multipleSelectionCV, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
      
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: SelectionCollectionViewCell.identifier,
        for: indexPath
      ) as! SelectionCollectionViewCell

      if let selection = item.selection {
        cell.configContent(by: selection)
      }
      
      return cell
    })
    dataSource.apply(snapshot)
  }
}
