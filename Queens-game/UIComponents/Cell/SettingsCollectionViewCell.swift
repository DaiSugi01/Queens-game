//
//  SettingsCollectionViewCell.swift
//  Queens-game
//
//  Created by Takayasu Nasu on 2021/05/09.
//

import UIKit
import RxSwift
import RxCocoa

fileprivate let disposeBag = DisposeBag()

class SettingsSwitcherCollectionViewCell: UICollectionViewCell {

  static let identifier = "settings switcher cell"

  var descriptionLabel: PLabel = {
    let lb = PLabel()
    lb.numberOfLines = 3
    lb.translatesAutoresizingMaskIntoConstraints = false
    return lb
  }()

  var switcher: UISwitch = {
    let sw = UISwitch()
    return sw
  }()

  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .equalCentering
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.configBgColor(bgColor: CustomColor.background)
    stackView.directionalLayoutMargins = .init(top: 16, leading: 16, bottom: 16, trailing: 16)
    return stackView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    super.contentView.addSubview(self.stackView)
    self.stackView.addArrangedSubview(descriptionLabel)
    self.stackView.addArrangedSubview(switcher)
    self.stackView.matchParent()
    self.descriptionLabel.widthAnchor.constraint(
      equalTo: self.stackView.widthAnchor,
      multiplier: 0.65
    ).isActive = true
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


}

class SettingsWaitingSecondsCollectionViewCell: UICollectionViewCell {

  static let identifier = "settings waiting seconds cell"

  var didTap = { (sec: Double) -> Void in print(sec) }

  var descriptionLabel: PLabel = {
    let lb = PLabel()
    lb.numberOfLines = 3
    lb.translatesAutoresizingMaskIntoConstraints = false
    return lb
  }()

  var sec: PLabel = {
    let lb = PLabel()
    lb.numberOfLines = 3
    lb.textAlignment = .right
    return lb
  }()

  var stepper: UIStepper = {
    let stepper = UIStepper()
    stepper.value = 5
    stepper.minimumValue = 2
    stepper.maximumValue = 8
    return stepper
  }()

  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .equalSpacing
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.configBgColor(bgColor: CustomColor.background)
    stackView.directionalLayoutMargins = .init(top: 16, leading: 16, bottom: 16, trailing: 16)
    return stackView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    super.contentView.addSubview(self.stackView)
    self.stackView.addArrangedSubview(self.descriptionLabel)
    self.stackView.addArrangedSubview(self.sec)
    self.stackView.addArrangedSubview(self.stepper)
    self.stackView.matchParent()
    self.descriptionLabel.widthAnchor.constraint(
      equalTo: self.stackView.widthAnchor,
      multiplier: 0.4
    ).isActive = true
    self.sec.widthAnchor.constraint(
      equalTo: self.stackView.widthAnchor,
      multiplier: 0.15
    ).isActive = true
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
