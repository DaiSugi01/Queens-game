//
//  SettingsViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

class SettingsViewController: UIViewController {

  let data = ["item1", "item2", "item3"]

  let viewModel: SettingViewModel = SettingViewModel(settings: Settings.shared)

  let closeButton: UIButton = {
    let bt = UIButton()
    bt.translatesAutoresizingMaskIntoConstraints = false
    bt.setTitle("Close", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    bt.addTarget(self, action: #selector(closeTapped(_:)), for: .touchUpInside)
    return bt
  }()

  let collectionView : UICollectionView = {
    var configuration = UICollectionLayoutListConfiguration(appearance: .sidebarPlain)
    configuration.backgroundColor = CustomColor.background
    let layout = UICollectionViewCompositionalLayout.list(using: configuration)
    let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
    collectionView.register(
      SettingsSwitcherCollectionViewCell.self,
      forCellWithReuseIdentifier: SettingsSwitcherCollectionViewCell.identifier
    )
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()

  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}

extension SettingsViewController {

  private func setupLayout() {
    view.configBgColor(bgColor: CustomColor.background)
    navigationItem.hidesBackButton = true
    navigationController?.navigationBar.barTintColor = CustomColor.background
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationItem.setRightBarButton(
      UIBarButtonItem(customView: closeButton),
      animated: true
    )

    self.collectionView.delegate = self
    self.collectionView.dataSource = self

    let stackView = VerticalStackView(
      arrangedSubviews: [
        H2Label(text: "Settings"),
        self.collectionView,
      ],
      spacing: 32
    )
    stackView.configLayout(superView: view, width: 360)
    stackView.centerXYin(view)
    stackView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
  }

  @objc func closeTapped(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}

extension SettingsViewController: UICollectionViewDataSource, UICollectionViewDelegate {

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.viewModel.settings.skipSettings().count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: SettingsSwitcherCollectionViewCell.identifier,
      for: indexPath as IndexPath
    ) as! SettingsSwitcherCollectionViewCell
    let row = self.viewModel.settings.skipSettings()
    cell.descriptionLabel.text = row[indexPath.row].description
    cell.switcher.setOn(row[indexPath.row].canSkip, animated: false)
    return cell
  }


}

