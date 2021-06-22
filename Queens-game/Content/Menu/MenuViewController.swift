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
    lb.setContentHuggingPriority(.required, for: .vertical)
    lb.textAlignment = .center
    return lb
  }()
  
  let howToPlayButton: MainButton = {
    let bt = MainButton()
    bt.setTitle("How to Play", for: .normal)
    bt.addTarget(self, action: #selector(howToPlayTapped(_:)), for: .touchUpInside)
    return bt
  }()
  
  let settingButton: MainButton = {
    let bt = MainButton()
    bt.setTitle("Settings", for: .normal)
    bt.addTarget(self, action: #selector(settingTapped(_:)), for: .touchUpInside)
    return bt
  }()
  
  let goToTopButton: MainButton = {
    let bt = MainButton()
    bt.setTitle("Go to Top", for: .normal)
    bt.addTarget(self, action: #selector(goToTop(_:)), for: .touchUpInside)
    return bt
  }()
  
  let privacyPolicyButton: SubButton = {
    let bt = SubButton()
    bt.setTitle("Privacy policy", for: .normal)
    bt.titleLabel?.font = CustomFont.p
    bt.addTarget(self, action: #selector(privacyPolicyTapped(_:)), for: .touchUpInside)
    return bt
  }()
  
  lazy var stackView: VerticalStackView = {
    let sv = VerticalStackView(
      arrangedSubviews: [
        screenTitle,
        howToPlayButton,
        settingButton,
        goToTopButton,
        privacyPolicyButton
      ],
      spacing: 24,
      alignment: .fill
    )
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.isLayoutMarginsRelativeArrangement = true
    sv.directionalLayoutMargins = .init(top: 32, leading: 40, bottom: 32, trailing: 40)
    sv.layer.cornerRadius = 24
    return sv
  }()
  
  let alert = UIAlertController(
    title: "Are you sure you want to quit current game ?",
    message:  "",
    preferredStyle:  UIAlertController.Style.alert
  )
  
  lazy var confirmAction = UIAlertAction(
    title: "Yes",
    style: UIAlertAction.Style.default,
    handler: { [weak self] (action: UIAlertAction!) -> Void in
      let nextViewController: UINavigationController = {
        let navigationController = UINavigationController(rootViewController: TopViewController())
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.navigationBar.isHidden = true
        
        return navigationController
      }()
      self?.present(nextViewController,  animated: true, completion: nil)
    }
  )
  
  let cancelAction = UIAlertAction(
    title: "No",
    style: UIAlertAction.Style.cancel,
    handler: { (action: UIAlertAction!) -> Void in
      print("No")
    }
  )
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //    backgroundCreator.configureLayout()
    setupLayout()
    self.alert.addAction(self.cancelAction)
    self.alert.addAction(self.confirmAction)
    
  }
  
  // This can detect if you touch outside of the content.
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    // Let user to dismiss when tapping out side
    if touches.first?.view == view{
      dismiss(animated: true, completion: nil)
    }
  }
  
}

extension MenuViewController {
  
  private func setupLayout() {
    view.configBgColor(bgColor: .clear)
    stackView.configBgColor(bgColor: CustomColor.background)
    stackView.configSuperView(under: view)
    stackView.configSize(width: 296)
    stackView.centerXYin(view)
  }
  
  @objc func goToTop(_ sender: UIButton) {
    present(self.alert, animated: true, completion: nil)
  }
  
  @objc func settingTapped(_ sender: UIButton) {
    let nx = SettingsViewController()
    let navigationController = UINavigationController(rootViewController:nx)
    present(navigationController, animated: true, completion: nil)
  }
  
  @objc func closeTapped(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
  @objc func howToPlayTapped(_ sender: UIButton) {
    let nx = RuleBookViewController()
    present(nx, animated: true, completion: nil)
  }
  
  @objc func privacyPolicyTapped(_ sender: UIButton) {
    
  }
}

