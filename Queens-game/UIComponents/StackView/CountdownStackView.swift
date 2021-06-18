//
//  CountdownStackView.swift
//  Queens-game
//
//  Created by Takayasu Nasu on 2021/05/14.
//

import UIKit

class CountdownStackView: VerticalStackView {

  let suits: [UILabel] = {
    let suits = ["♠","♦","♥","♣"]
    let suitLabels: [UILabel] = suits.map { suit in
      let label = UILabel()
      label.text = suit
      label.font = CustomFont.h2
      if ["♦","♥"].contains(suit) {
        label.textColor = .red
      }
      return label
    }
    return suitLabels
  }()

  lazy var above: HorizontalStackView = {
    let stackView = HorizontalStackView(
      arrangedSubviews: [suits[0], suits[1]],
      distribution: .equalSpacing
    )
    return stackView
  }()

  lazy var countdownLabel: UILabel = {
    let label = UILabel()
    label.font = CustomFont.h1
    label.textAlignment = .center
    label.sizeToFit()
    return label
  }()

  lazy var sec: H4Label = {
    let label = H4Label(text: "sec")
    label.textAlignment = .center
    return label
  }()

  lazy var middle: VerticalStackView = {
    let stackView = VerticalStackView(
      arrangedSubviews: [countdownLabel, sec],
      distribution: .equalSpacing
    )
    return stackView
  }()

  lazy var below: HorizontalStackView = {
    let stackView = HorizontalStackView(
      arrangedSubviews: [suits[2], suits[3]],
      distribution: .equalSpacing
    )
    return stackView
  }()

  lazy var countdownBlock: VerticalStackView = {
    let stackView = VerticalStackView(
      arrangedSubviews: [
        self.above,
        self.middle,
        self.below
      ]
    )
    return stackView
  }()

  /// Custom initializer to create the view
  /// - Parameters:
  ///   - countdown: The view you want to set countdown text as Int. Default is 5.
  ///   - padding:set padding top and bottom of countdown number.
  init(countdown: Int = 5, padding: CGFloat = 32) {
    super.init(
      arrangedSubviews: [],
      alignment: .center
    )
    self.addArrangedSubview(countdownBlock)
    self.countdownBlock.spacing = padding
    self.countdownLabel.text = String(countdown)
    self.countdownBlock.widthAnchor.constraint(
      equalTo: super.widthAnchor,
      multiplier: 0.8
    ).isActive = true
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
