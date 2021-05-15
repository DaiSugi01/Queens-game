//
//  ResultViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

class ResultViewController: UIViewController {

  let navButtons = NextAndBackButtons()

  let screenTitle: H2Label = {
    let lb = H2Label(text: "It’s time to carry out ")
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.lineBreakMode = .byWordWrapping
    lb.numberOfLines = 0
    lb.setContentHuggingPriority(.required, for: .vertical)
    return lb
  }()

  lazy var stackView: VerticalStackView = {
    let sv = VerticalStackView(
      arrangedSubviews: [
        screenTitle,
        navButtons,
      ]
    )
    sv.alignment = .fill
    sv.distribution = .equalSpacing
    return sv
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupLayout()
    self.configureButtons()
  }
}

extension ResultViewController {

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

  }

  private func configureButtons() {
    navButtons.nextButton.setTitle("Play again", for: .normal)
    navButtons.nextButton.titleLabel?.font = CustomFont.h4
    navButtons.nextButton.addTarget(
      self,
      action: #selector(toStart),
      for: .touchUpInside
    )
    
    navButtons.backButton.setTitle("Back to start menu", for: .normal)
    navButtons.backButton.titleLabel?.font = CustomFont.h4
    navButtons.backButton.titleLabel?.lineBreakMode = .byWordWrapping
    navButtons.backButton.addTarget(
      self,
      action: #selector(toTop),
      for: .touchUpInside
    )

  }

  @objc private func toStart() {
    let nx = PlayerSelectionViewController()
    GameManager.shared.pushGameProgress(
      navVC: navigationController!,
      currentScreen: self,
      nextScreen: nx
    )
  }

  @objc private func toTop() {
    super.navigationController?.popToRootViewController(animated: true)
  }
  
}
