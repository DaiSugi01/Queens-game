//
//  SettingsCollectionViewCell.swift
//  Queens-game
//
//  Created by Takayasu Nasu on 2021/05/09.
//

import UIKit

class SettingsSwitcherCollectionViewCell: UICollectionViewCell {

  static let identifier = "settings cell"

  var descriptionLabel: PLabel = {
    let lb = PLabel()
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
    stackView.distribution = .equalSpacing
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
    self.stackView.matchSize()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


}
