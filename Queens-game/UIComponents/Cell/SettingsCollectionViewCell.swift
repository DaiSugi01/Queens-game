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

class SettingsSwitcherStackView: UIStackView {

  var descriptionLabel: H4Label = {
    let lb = H4Label()
    lb.numberOfLines = 3
    return lb
  }()

  var switcher: UISwitch = {
    let sw = UISwitch()
    return sw
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.translatesAutoresizingMaskIntoConstraints = false
    self.axis = .horizontal
    self.alignment = .center
    self.distribution = .equalCentering
    self.backgroundColor = .clear
    
    self.isLayoutMarginsRelativeArrangement = true
    self.directionalLayoutMargins = .init(top: 32, leading: 8, bottom: 32, trailing: 8)
    
    self.addArrangedSubview(descriptionLabel)
    self.addArrangedSubview(switcher)
  }
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class SettingsWaitingTimeStackView: UIStackView {
  
  var didTap = { (sec: Double) -> Void in print(sec) }

  var descriptionLabel: H4Label = {
    let lb = H4Label()
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

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.translatesAutoresizingMaskIntoConstraints = false
    self.axis = .horizontal
    self.alignment = .center
    self.distribution = .equalCentering
    self.backgroundColor = .clear
    
    self.isLayoutMarginsRelativeArrangement = true
    self.directionalLayoutMargins = .init(top: 32, leading: 8, bottom: 32, trailing: 8)
    
    self.addArrangedSubview(self.descriptionLabel)
    self.addArrangedSubview(self.sec)
    self.addArrangedSubview(self.stepper)
  }
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class SettingsSwitcherCollectionViewCell: UICollectionViewCell {

  static let identifier = "settings switcher cell"

  var descriptionLabel: H4Label = {
    let lb = H4Label()
    lb.numberOfLines = 3
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
    stackView.configBgColor(bgColor: .clear)
    stackView.directionalLayoutMargins = .init(top: 32, leading: 8, bottom: 32, trailing: 8)
    return stackView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.contentView.addSubview(self.stackView)
    self.stackView.addArrangedSubview(descriptionLabel)
    self.stackView.addArrangedSubview(switcher)
    self.stackView.anchors(topAnchor: contentView.topAnchor, leadingAnchor: contentView.leadingAnchor, trailingAnchor: contentView.trailingAnchor, bottomAnchor: contentView.bottomAnchor)
    self.descriptionLabel.widthAnchor.constraint(
      equalTo: self.stackView.widthAnchor,
      multiplier: 0.65
    ).isActive = true
    
//   let s =  SettingsSwitcherStackView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


}

class SettingsWaitingSecondsCollectionViewCell: UICollectionViewCell {

  static let identifier = "settings waiting seconds cell"

  var didTap = { (sec: Double) -> Void in print(sec) }

  var descriptionLabel: H4Label = {
    let lb = H4Label()
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
    stackView.configBgColor(bgColor: .clear)
    stackView.directionalLayoutMargins = .init(top: 32, leading: 8, bottom: 32, trailing: 8)
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
