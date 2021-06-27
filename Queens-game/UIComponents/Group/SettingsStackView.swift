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
  
  let identifier: String!

  var descriptionLabel: H4Label = {
    let lb = H4Label()
    return lb
  }()

  var switcher: UISwitch = {
    let sw = UISwitch()
    sw.onTintColor = CustomColor.main
    sw.setContentHuggingPriority(.required, for: .horizontal)
    return sw
  }()

  init(_ identifier: String) {
    self.identifier = identifier
    super.init(frame: .zero)

    self.translatesAutoresizingMaskIntoConstraints = false
    self.axis = .horizontal
    self.alignment = .center
    self.distribution = .fill
    self.backgroundColor = .clear
    
    self.isLayoutMarginsRelativeArrangement = true
    self.directionalLayoutMargins = .init(top: 24, leading: 2, bottom: 24, trailing: 2)
    
    self.addArrangedSubview(descriptionLabel)
    self.addArrangedSubview(switcher)
  }
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


class SettingsWaitingTimeStackView: UIStackView {
  let identifier: String!
  
  var didTap = { (sec: Double) -> Void in print(sec) }

  var descriptionLabel: H4Label = {
    let lb = H4Label()
    lb.translatesAutoresizingMaskIntoConstraints = false
    return lb
  }()

  var sec: H4Label = {
    let lb = H4Label()
    lb.textAlignment = .center
    return lb
  }()

  var stepper: UIStepper = {
    let stepper = UIStepper()
    stepper.translatesAutoresizingMaskIntoConstraints = false
    stepper.value = 5
    stepper.minimumValue = 2
    stepper.maximumValue = 8
    return stepper
  }()
  
  lazy var secStepperWrapper: VerticalStackView = {
    let sv = VerticalStackView(
      arrangedSubviews: [sec, stepper],
      spacing: 8,
      alignment: .center
    )
    return sv
  } ()

  init(_ identifier: String) {
    self.identifier = identifier
    super.init(frame: .zero)
    
    self.translatesAutoresizingMaskIntoConstraints = false
    self.axis = .horizontal
    self.alignment = .center
    self.distribution = .fill
    self.backgroundColor = .clear
    self.spacing = 8
    
    self.isLayoutMarginsRelativeArrangement = true
    self.directionalLayoutMargins = .init(top: 24, leading: 2, bottom: 24, trailing: -2)
    
    self.addArrangedSubview(descriptionLabel)
    self.addArrangedSubview(secStepperWrapper)
    secStepperWrapper.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
  }
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}