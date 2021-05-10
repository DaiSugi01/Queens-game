//
//  QueenSelectionViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/05/09.
//

import UIKit

class QueenSelectionViewController: UIViewController, UICollectionViewDelegate {

    
  var sections: [DemoSection] = [.selection]
  
  var dataSource: UICollectionViewDiffableDataSource<DemoSection, DemoItem>!
  var snapshot: NSDiffableDataSourceSnapshot<DemoSection, DemoItem> {
    var ss = NSDiffableDataSourceSnapshot<DemoSection, DemoItem>()
    ss.appendSections([.selection])
//    ss.appendItems(DemoItem.wrap(items: DemoSampleData.options))
    ss.appendItems(DemoItem.wrapSelection(items: DemoSampleData.options), toSection: .selection)
    sections = ss.sectionIdentifiers
    return ss
  }
  
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
    collectionView.backgroundColor = CustomColor.background
    collectionView.register(
      SelectionCollectionViewCell.self,
      forCellWithReuseIdentifier: SelectionCollectionViewCell.identifier)
    return collectionView
  }()
  
  let navButtons = NextAndBackButtons()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    multipleSelectionCV.delegate = self
    multipleSelectionCV.setCollectionViewLayout(generateLayout(), animated: true)
    createDataSource()
    setupLayout()
    setButtonActions()
  }
  
  private func setupLayout() {
    navigationItem.hidesBackButton = true
    view.backgroundColor = CustomColor.background
    
//    let verticalSV = VerticalStackView(arrangedSubviews: [screenTitle, multipleSelectionCV, navButtons])
//    verticalSV.alignment = .center
//    verticalSV.spacing = 40
//    verticalSV.translatesAutoresizingMaskIntoConstraints = false
//    verticalSV.distribution = .equalSpacing
//    view.addSubview(verticalSV)
//    verticalSV.matchParent(padding: .init(top: 64, left: 32, bottom: 64, right: 32))
    view.addSubview(screenTitle)
    view.addSubview(navButtons)
    view.addSubview(multipleSelectionCV)
    screenTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64).isActive = true
    screenTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
    screenTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32).isActive = true

    navButtons.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -64).isActive = true
    navButtons.centerXin(view)
//
//    multipleSelectionCV.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: 40).isActive = true
    multipleSelectionCV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
    multipleSelectionCV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32).isActive = true
    multipleSelectionCV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
//

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
