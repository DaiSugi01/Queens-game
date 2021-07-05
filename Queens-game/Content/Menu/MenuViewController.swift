//
//  MenuViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit

class MenuViewController: UIViewController {
  
  let viewModel = MenuViewModel()
  
  let screenTitle: H2Label = {
    let lb = H2Label(text: "Menu")
    lb.setContentHuggingPriority(.required, for: .vertical)
    lb.textAlignment = .center
    return lb
  }()
  
  let howToPlayButton: MainButton = {
    let bt = MainButton()
    bt.configureRadius(radius: 28)
    bt.setTitle("How to Play", for: .normal)
    bt.insertIcon(
      IconFactory.createSystemIcon(
        "questionmark.circle",
        color: CustomColor.background,
        pointSize: 17
      ),
      to: .left
    )
    return bt
  }()
  
  let settingButton: MainButton = {
    let bt = MainButton()
    bt.configureRadius(radius: 28)
    bt.setTitle("Settings", for: .normal)
    bt.insertIcon(IconFactory.createSystemIcon("gear", color: CustomColor.background, pointSize: 16), to: .left)
    return bt
  }()
  
  let goToTopButton: MainButton = {
    let bt = MainButton()
    bt.configureRadius(radius: 28)
    let btTintColor = CustomColor.background.resolvedColor(with: .init(userInterfaceStyle: .light))
    bt.setTitle("Back to Top", for: .normal)
    bt.setTitleColor(btTintColor, for: .normal)
    bt.backgroundColor = CustomColor.accent
    bt.insertIcon(
      IconFactory.createSystemIcon("suit.heart.fill", color: btTintColor, pointSize: 16),
      to: .left
    )
    return bt
  }()
  
  let privacyPolicyButton: SubButton = {
    let bt = SubButton()
    bt.setTitle("Privacy policy", for: .normal)
    bt.setTitleColor(CustomColor.subText, for: .normal)
    bt.backgroundColor = .clear
    bt.titleLabel?.font = CustomFont.p
    bt.insertIcon(nil, to: .left)
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
    sv.setCustomSpacing(16, after: goToTopButton)
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.isLayoutMarginsRelativeArrangement = true
    sv.directionalLayoutMargins = .init(top: 32, leading: 40, bottom: 40, trailing: 40)
    
    sv.backgroundColor = UIColor(patternImage: BackgroundImage.image)
    
    sv.layer.cornerRadius = 16
    sv.layer.borderWidth = 3
    sv.layer.borderColor = traitCollection.userInterfaceStyle == .light ? CustomColor.text.withAlphaComponent(0.8).cgColor : CustomColor.subText.cgColor
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
      
      if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
        
        let loadingView = LoadingView()
        loadingView.alpha = 0
        loadingView.frame = window.frame
        loadingView.label.text = "Quitting..."
        window.addSubview(loadingView)
        
        UIView.animate(withDuration: 0.24, delay: 0, options: .curveEaseInOut) {
          loadingView.alpha = 1
        } completion: { _ in
          GameManager.shared.loadGameProgress(
            to: .home,
            with: self?.viewModel.navigationController
          )
          
          UIView.animate(withDuration: 0.6, delay: 0, options: .beginFromCurrentState) {
            loadingView.icon.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
          } completion: { _ in
            self?.dismiss(animated: false, completion: nil)
            
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut) {
              loadingView.alpha = 0
            } completion: { _ in
              loadingView.removeFromSuperview()
            }
          }
        }
        
      }
      
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
    
    configureLayout()
    alert.addAction(self.cancelAction)
    alert.addAction(self.confirmAction)

    configureBindings()
  }
  
  deinit {
    print("\(Self.self) is being deinitialized")
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
  
  private func configureLayout() {
    view.configureBgColor(bgColor: .clear)

    goToTopButton.isHidden = viewModel.isTopMenu
    privacyPolicyButton.isHidden = !viewModel.isTopMenu
    
    stackView.configureSuperView(under: view)
    stackView.configureSize(width: 296)
    stackView.centerXYin(view)
  }
  
  private func configureBindings() {
    goToTopButton.rx
      .tap
      .bind { [weak self] _ in
        guard let self = self else { return }
        self.present(self.alert, animated: true, completion: nil)
      }
      .disposed(by: viewModel.disposeBag)
    
    settingButton.rx
      .tap
      .bind { [weak self] _ in
        let nx = SettingsViewController()
        let navigationController = UINavigationController(rootViewController: nx)
        navigationController.navigationBar.isHidden = true
        self?.present(navigationController, animated: true, completion: nil)
      }
      .disposed(by: viewModel.disposeBag)
    
    howToPlayButton.rx
      .tap
      .bind { [weak self] _ in
        let nx = WebViewViewController(url: "https://daisugi01.github.io/Queens-game/play-guide")
        self?.present(nx, animated: true, completion: nil)
      }
      .disposed(by: viewModel.disposeBag)
    
    privacyPolicyButton.rx
      .tap
      .bind { [weak self] _ in
        let nx = WebViewViewController(url: "https://daisugi01.github.io/Queens-game/privacy-policy")
        self?.present(nx, animated: true, completion: nil)
      }
      .disposed(by: viewModel.disposeBag)
  }
}


