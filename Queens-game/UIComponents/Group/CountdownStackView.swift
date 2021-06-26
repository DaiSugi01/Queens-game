//
//  CountdownStackView.swift
//  Queens-game
//
//  Created by Takayasu Nasu on 2021/05/14.
//

import UIKit

protocol CountdownGroup where Self: UIView {
  var spadeSuit: UIImageView {get set}
  var heartSuit: UIImageView {get set}
  var diamondSuit: UIImageView {get set}
  var clubSuit: UIImageView {get set}
}

class CountdownStackView: UIView, CountdownGroup {
  
  // Countdown
  lazy var countdownLabel: UILabel = {
    let label = UILabel()
    label.font = CustomFont.h1
    label.textAlignment = .center
    label.sizeToFit()
    return label
  }()

  lazy var countdownUnit: H4Label = {
    let label = H4Label(text: "sec")
    label.textAlignment = .center
    return label
  }()

  lazy var countDownWrapper: VerticalStackView = {
    let stackView = VerticalStackView(
      arrangedSubviews: [countdownLabel, countdownUnit],
      distribution: .equalSpacing
    )
    return stackView
  }()
  
  // suits
  var spadeSuit = UIImageView(
    image: IconFactory.createSystemIcon(
      "suit.spade.fill",
      pointSize: 32
    )
  )
  var heartSuit = UIImageView(
    image: IconFactory.createSystemIcon(
      "suit.heart.fill",
      color: CustomColor.accent,
      pointSize: 32
    )
  )
  var diamondSuit = UIImageView(
    image: IconFactory.createSystemIcon(
      "suit.diamond.fill",
      color: CustomColor.accent,
      pointSize: 32)
  )
  var clubSuit = UIImageView(
    image: IconFactory.createSystemIcon(
      "suit.club.fill",
      pointSize: 32
    )
  )
  
  lazy var suitsWrapper: UIView = {
    let uv = UIView()
    uv.translatesAutoresizingMaskIntoConstraints = false
    spadeSuit.translatesAutoresizingMaskIntoConstraints = false
    heartSuit.translatesAutoresizingMaskIntoConstraints = false
    diamondSuit.translatesAutoresizingMaskIntoConstraints = false
    clubSuit.translatesAutoresizingMaskIntoConstraints = false
    
    uv.addSubview(spadeSuit)
    uv.addSubview(heartSuit)
    uv.addSubview(diamondSuit)
    uv.addSubview(clubSuit)
    
    NSLayoutConstraint.activate([
      spadeSuit.topAnchor.constraint(equalTo: uv.topAnchor),
      spadeSuit.leadingAnchor.constraint(equalTo: uv.leadingAnchor),
      heartSuit.topAnchor.constraint(equalTo: uv.topAnchor),
      heartSuit.trailingAnchor.constraint(equalTo: uv.trailingAnchor),
      clubSuit.bottomAnchor.constraint(equalTo: uv.bottomAnchor),
      clubSuit.trailingAnchor.constraint(equalTo: uv.trailingAnchor),
      diamondSuit.bottomAnchor.constraint(equalTo: uv.bottomAnchor),
      diamondSuit.leadingAnchor.constraint(equalTo: uv.leadingAnchor)
    ])
    return uv
  }()

  /// Custom initializer to create the view
  /// - Parameters:
  ///   - countdown: The view you want to set countdown text as Int. Default is 5.
  ///   - padding:set padding top and bottom of countdown number.
  init(countdown: Int = 5, padding: CGFloat = 32) {
    super.init(frame: .zero)
    self.translatesAutoresizingMaskIntoConstraints = false
    
    countDownWrapper.configSuperView(under: self)
    countDownWrapper.centerXYin(self)
    
    suitsWrapper.configSuperView(under: self)
    suitsWrapper.centerXYin(self)
    suitsWrapper.configSize(width: 200, height: 200)
    
    self.countdownLabel.text = String(countdown)

  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
