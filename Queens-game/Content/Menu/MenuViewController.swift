//
//  MenuViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

class MenuViewController: UIViewController {

  let screenTitle: H2Label = {
    let lb = H2Label(text: "Menu")
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.lineBreakMode = .byWordWrapping
    lb.numberOfLines = 0
    lb.setContentHuggingPriority(.required, for: .vertical)
    return lb
  }()

  let closeButton: UIButton = {
    let bt = UIButton()
    bt.translatesAutoresizingMaskIntoConstraints = false
    bt.setTitle("Close", for: .normal)
    bt.backgroundColor = .black
    bt.setTitleColor(.white, for: .normal)
    return bt
  }()

  
  let howToPlayButton: UIButton = {
    let bt = UIButton()
    bt.translatesAutoresizingMaskIntoConstraints = false
    bt.setTitle("How to Palay", for: .normal)
    bt.backgroundColor = .black
    bt.setTitleColor(.white, for: .normal)
    bt.addTarget(self, action: #selector(howToPlaytapped(_:)), for: .touchUpInside)
    return bt
  }()

  @objc func howToPlaytapped(_ sender: UIButton) {
    let nx = RuleBookViewController()
    present(nx, animated: true, completion: nil)
  }
  
  let settingButton: UIButton = {
    let bt = UIButton()
    bt.translatesAutoresizingMaskIntoConstraints = false
    bt.setTitle("Settings", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    bt.addTarget(self, action: #selector(settingTapped(_:)), for: .touchUpInside)
    return bt
  }()

  @objc func settingTapped(_ sender: UIButton) {
    let nx = SettingsViewController()
    present(nx, animated: true, completion: nil)
  }
  
  let goToTopButton: UIButton = {
    let bt = UIButton()
    bt.translatesAutoresizingMaskIntoConstraints = false
    bt.setTitle("Go to Top", for: .normal)
    bt.setTitleColor(.black, for: .normal)
    bt.addTarget(self, action: #selector(goToTop(_:)), for: .touchUpInside)
    return bt
  }()

  lazy var stackView: VerticalStackView = {
    let sv = VerticalStackView(
      arrangedSubviews: [
        screenTitle,
        closeButton,
        howToPlayButton,
        settingButton,
        goToTopButton
      ]
    )
    sv.alignment = .fill
    sv.distribution = .equalSpacing
    sv.translatesAutoresizingMaskIntoConstraints = false
    return sv
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
  }

}

extension MenuViewController {

  private func setupLayout() {
    view.configBgColor(bgColor: CustomColor.background)
    navigationItem.hidesBackButton = true
    navigationController?.navigationBar.barTintColor = CustomColor.background
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationItem.setRightBarButton(
      UIBarButtonItem(customView: closeButton),
      animated: true
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

  @objc func goToTop(_ sender: UIButton) {
    let nx = ExitAlertViewController()
    present(nx, animated: true, completion: nil)
  }
}
