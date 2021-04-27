//
//  CommandSelectionViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

private let reuseIdentifier = "Cell"

class CommandSelectionViewController: UICollectionViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    setupLayout()
  }
  
  // MARK: UICollectionViewDataSource
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 0
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 0
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    return cell
  }
  
  
  
  // TODO: Delete below before you imprement
  let screenName: UILabel = {
    let lb = UILabel()
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.text = "Command Selection"
    
    return lb
  }()
  
  let nextButton: UIButton = {
    let bt = UIButton()
    bt.translatesAutoresizingMaskIntoConstraints = false
    bt.setTitle("Next", for: .normal)
    bt.backgroundColor = .black
    bt.setTitleColor(.white, for: .normal)
    bt.addTarget(self, action: #selector(goToNext(_:)), for: .touchUpInside)
    
    return bt
  }()
  
  let backButton: UIButton = {
    let bt = UIButton()
    bt.translatesAutoresizingMaskIntoConstraints = false
    bt.setTitle("Back", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    bt.addTarget(self, action: #selector(goBack(_:)), for: .touchUpInside)
    
    return bt
  }()
  
  @objc func goToNext(_ sender: UIButton) {
    let nx = CommandManualSelectingViewController(collectionViewLayout: UICollectionViewFlowLayout())
    navigationController?.pushViewController(nx, animated: true)
  }
  
  @objc func goBack(_ sender: UIButton) {
    navigationController?.popViewController(animated: true)
  }
  
  private func setupLayout() {
    collectionView.backgroundColor = .white
    navigationItem.hidesBackButton = true
    
    view.addSubview(screenName)
    view.addSubview(nextButton)
    view.addSubview(backButton)
    
    screenName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    screenName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
    
    nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    
    backButton.trailingAnchor.constraint(equalTo: nextButton.leadingAnchor, constant: -10).isActive = true
    backButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }  
}
