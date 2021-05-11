//
//  CommandSettingViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

private let reuseIdentifier = "Cell"

class CommandSettingViewController: UIViewController {
  
  let sections: [Section] = [.command]
  
  var snapshot: NSDiffableDataSourceSnapshot<Section, Item>!
  var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
  
  let lb = H2Label(text: "Dummy title")
  let collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewLayout()
  )
  lazy var stackView: VerticalStackView = {
    let sv = VerticalStackView(arrangedSubviews: [lb, collectionView])
    return sv
  }()
  
  override func viewDidLoad() {
    view.configBgColor(bgColor: CustomColor.background)
    stackView.configLayout(
      superView: view
    )
    stackView.matchParent()
  }

//  override func viewDidLoad() {
//    super.viewDidLoad()
//    self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//    setupLayout()
//  }
//  
//  // MARK: UICollectionViewDataSource
//  
//  override func numberOfSections(in collectionView: UICollectionView) -> Int {
//    return 0
//  }
//  
//  
//  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    return 0
//  }
//  
//  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
//    return cell
//  }
//  
//  
//  
//  // TODO: Delete below before you imprement
//  let screenName: UILabel = {
//    let lb = UILabel()
//    lb.translatesAutoresizingMaskIntoConstraints = false
//    lb.text = "Edit command"
//    
//    return lb
//  }()
//  
//  let addButton: UIButton = {
//    let bt = UIButton()
//    bt.translatesAutoresizingMaskIntoConstraints = false
//    bt.setTitle("Add", for: .normal)
//    bt.backgroundColor = .black
//    bt.setTitleColor(.white, for: .normal)
//    bt.addTarget(self, action: #selector(goToaddEdit(_:)), for: .touchUpInside)
//    
//    return bt
//  }()
//  
//  @objc func goToaddEdit(_ sender: UIButton) {
//    let nx = CommandEditViewController()
//    present(nx, animated: true, completion: nil)
//  }
//  
//  private func setupLayout() {
//    collectionView.backgroundColor = .white
//    
//    view.addSubview(screenName)
//    view.addSubview(addButton)
//
//    screenName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//    screenName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
//    
//    addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//    addButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true    
//  }

}
