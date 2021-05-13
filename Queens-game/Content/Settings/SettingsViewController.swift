//
//  SettingsViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit
import RxSwift
import RxCocoa

class SettingsViewController: UIViewController {

  let disposeBag = DisposeBag()

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
    var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
    configuration.backgroundColor = CustomColor.background
    let layout = UICollectionViewCompositionalLayout.list(using: configuration)
    let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
    collectionView.register(
      SettingsSwitcherCollectionViewCell.self,
      forCellWithReuseIdentifier: SettingsSwitcherCollectionViewCell.identifier
    )
    collectionView.register(
      SettingsWaitingSecondsCollectionViewCell.self,
      forCellWithReuseIdentifier: SettingsWaitingSecondsCollectionViewCell.identifier
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
    view.addSubview(stackView)
    stackView.topAnchor.constraint(
      equalTo: view.topAnchor,
      constant: Constant.Common.topSpacing
    ).isActive = true
    stackView.bottomAnchor.constraint(
      equalTo: view.bottomAnchor,
      constant: Constant.Common.bottomSpacing
    ).isActive = true
    stackView.leadingAnchor.constraint(
      equalTo: view.safeAreaLayoutGuide.leadingAnchor,
      constant: Constant.Common.leadingSpacing
    ).isActive = true
    stackView.trailingAnchor.constraint(
      equalTo: view.safeAreaLayoutGuide.trailingAnchor,
      constant:  Constant.Common.trailingSpacing
    ).isActive = true

  }

  @objc func closeTapped(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}

extension SettingsViewController: UICollectionViewDataSource, UICollectionViewDelegate {

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if section == 0 {
      return self.viewModel.settings.skipSettings().count
    }
    return self.viewModel.settings.waitingSeconds().count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if indexPath.section == 0 {
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: SettingsSwitcherCollectionViewCell.identifier,
        for: indexPath as IndexPath
      ) as! SettingsSwitcherCollectionViewCell

      let row = self.viewModel.settings.skipSettings()
      cell.descriptionLabel.text = row[indexPath.item].description
      cell.switcher.setOn(row[indexPath.item].canSkip, animated: false)

      // RxSwift
      let relay = self.viewModel.skipRelays[indexPath.item]
      cell.switcher.rx.isOn.asObservable()
        .subscribe(onNext: {
          relay.accept($0)
        })
        .disposed(by: disposeBag)
      return cell
    } else {
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: SettingsWaitingSecondsCollectionViewCell.identifier,
        for: indexPath as IndexPath
      ) as! SettingsWaitingSecondsCollectionViewCell

      let row = self.viewModel.settings.waitingSeconds()
      cell.descriptionLabel.text = row[indexPath.item].description
      let sec = row[indexPath.item].sec
      cell.stepper.value = sec
      cell.sec.text = "\(Int(sec)) sec"

      // RxSwift
      let relay = self.viewModel.waitingRelays[indexPath.item]
      cell.stepper.rx.value.asObservable()
        .subscribe(onNext: {
          relay.accept($0)
          cell.sec.text = "\(Int($0)) sec"
        })
        .disposed(by: disposeBag)
      return cell
    }

  }


}

