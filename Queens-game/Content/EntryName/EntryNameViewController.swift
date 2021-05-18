//
//  EntryNameCollectionViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit
import RxSwift
import RxCocoa

class EntryNameViewController: UIViewController {
  
  let vm = EntryNameViewModel()
  let disposeBag: DisposeBag = DisposeBag()
  let users = GameManager.shared.users

  let sections: [Section] = [.userName]
//  var snapshot: NSDiffableDataSourceSnapshot<Section, Item>!
//  var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
  
  lazy var verticalSV: VerticalStackView = {
    let sv = VerticalStackView(arrangedSubviews: [screenTitle, collectionView])
    sv.alignment = .fill
    sv.distribution = .equalSpacing
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.spacing = 40
    return sv
  }()
  
  let screenTitle: H2Label = {
    let lb = H2Label(text: "Enter Player names")
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.lineBreakMode = .byWordWrapping
    lb.numberOfLines = 0
    lb.setContentHuggingPriority(.required, for: .vertical)
    return lb
  }()
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    let collectionView = UICollectionView(
      frame: .zero,collectionViewLayout: layout
    )
    collectionView.constraintHeight(equalToConstant: 360)
    return collectionView
  }()
  
  let navButtons: NextAndBackButtons = {
    let bts = NextAndBackButtons()
    bts.nextButton.addTarget(self, action: #selector(goToNext(_:)), for: .touchUpInside)
    bts.backButton.addTarget(self, action: #selector(goBackToPrevious(_:)), for: .touchUpInside)
    
    return bts
  }()
  
  @objc private func goToNext(_ sender: UIButton) {
    for user in GameManager.shared.users {
      print(user.playerId, user.name)
    }
//    vm.saveUsers()
//    let nx = QueenSelectedViewController()
//    GameManager.shared.pushGameProgress(navVC: navigationController!,
//                                        currentScreen: self,
//                                        nextScreen: nx)
  }
  
  @objc private func goBackToPrevious(_ sender: UIButton) {
    GameManager.shared.popGameProgress(navVC: navigationController!)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    setupLayout()
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(UsernameInputCollectionViewCell.self,
                            forCellWithReuseIdentifier: UsernameInputCollectionViewCell.identifier)
//    vm.getUsersFromUserDefaults()
  }
  
  /// Setup layout and datasource for collection view
  private func setupCollectionView() {
    createCollectionViewLayout()
//    createDiffableDataSource()
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
    
    navButtons.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:
                                        Constant.Common.bottomSpacing).isActive = true
    navButtons.centerXin(view)
  }
}

extension EntryNameViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return users.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: UsernameInputCollectionViewCell.identifier,
      for: indexPath
    ) as! UsernameInputCollectionViewCell
    cell.configContent(by: users[indexPath.row].playerId, and: users[indexPath.row].name)

    // Observe text field
    cell.textField.rx.text.asObservable()
      .subscribe(onNext: { [self] value in
        vm.updateUserName(playerId: users[indexPath.row].playerId-1, newName: value!)
//        self.collectionView.reloadItems(at: [indexPath])
      })
      .disposed(by: self.disposeBag)
//    cell.prepareForReuse()
    return cell
  }
}
