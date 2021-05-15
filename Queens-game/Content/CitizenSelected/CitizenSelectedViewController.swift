//
//  CitizenSelectedViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit
import RxSwift
import RxCocoa

class CitizenSelectedViewController: UIViewController {

  let viewModel = CitizenSelectedViewModel()

  let disposeBag = DisposeBag()

  let screenTitle: H2Label = {
    let lb = H2Label(text: "Selecting the citizen...")
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.lineBreakMode = .byWordWrapping
    lb.numberOfLines = 0
    lb.setContentHuggingPriority(.required, for: .vertical)
    return lb
  }()

  let skipButton: SubButton = {
    let button = SubButton()
    button.setTitle("Skip", for: .normal)
    button.addTarget(self, action: #selector(skipButtonTapped(_:)), for: .touchUpInside)
    return button
  }()

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
    label.text = String(self.viewModel.countdonwTime)
    label.font = CustomFont.h1
    label.textAlignment = .center
    label.sizeToFit()
    return label
  }()

  lazy var sec: UILabel = {
    let label = UILabel()
    label.text = "sec"
    label.textAlignment = .center
    return label
  }()

  lazy var center: VerticalStackView = {
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
        self.center,
        self.below
      ]
    )
    stackView.spacing = 32
    return stackView
  }()

  lazy var wrapperCountdownBlock: VerticalStackView = {
    let stackView = VerticalStackView(arrangedSubviews: [countdownBlock])
    stackView.alignment = .center
    return stackView
  }()

  lazy var stackView: VerticalStackView = {
    let sv = VerticalStackView(
      arrangedSubviews: [
        screenTitle,
        wrapperCountdownBlock,
        skipButton
      ]
    )
    sv.alignment = .fill
    sv.distribution = .equalSpacing
    return sv
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
    //    self.viewModel.countdown()
    self.viewModel.rxCountdownTime
      .subscribe(onNext: { [weak self] time in
        self?.countdownLabel.text = String(time!)
      },
      onCompleted: {
        self.replaceView()
      })
      .disposed(by: disposeBag)
  }
  
}

extension CitizenSelectedViewController {

  private func setupLayout() {
    view.configBgColor(bgColor: CustomColor.background)
    navigationItem.hidesBackButton = true

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
    countdownBlock.widthAnchor.constraint(
      equalTo: wrapperCountdownBlock.widthAnchor,
      multiplier: 0.8
    ).isActive = true
  }

  @objc func skipButtonTapped(_ sender: UIButton) {
    self.stackView.removeFromSuperview()
    self.toResult()
  }

  private func toResult() {
    let nx = ResultViewController()
    GameManager.shared.pushGameProgress(
      navVC: navigationController!,
      currentScreen: self,
      nextScreen: nx
    )
  }

  private func replaceView() {
    self.stackView.removeFromSuperview()
  }

}
