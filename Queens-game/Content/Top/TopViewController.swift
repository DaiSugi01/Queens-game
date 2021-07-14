//
//  TopViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit
import RxSwift
import RxCocoa

class TopViewController: UIViewController, QueensGameViewControllerProtocol {
  
  lazy var backgroundCreator: BackgroundCreator = BackgroundCreatorPlain(parentView: view)
  
  private let popUpTransitioning = PopUpTransitioningDelegatee()
  
  private let disposeBag = DisposeBag()
  
  private let screenTitle: H1Label = {
    let lb = H1Label()
    let title = NSMutableAttributedString(string: "Queen's Game")
    title.addAttribute(
      .foregroundColor,
      value: CustomColor.accent,
      range: NSMakeRange(0, 1)
    )
    lb.attributedText = title
    lb.numberOfLines = 2
    return lb
  }()
  
  private lazy var buttonWrapper: VerticalStackView = {
    let sv = VerticalStackView(
      arrangedSubviews: [
        startButton,
        editCommandButton,
        menuButtonAtTopPage
      ]
    )
    sv.alignment = .leading
    sv.setCustomSpacing(16, after: startButton)
    return sv
  }()
  
  private let startButton = MainButton(title: "Start game")
  
  private let editCommandButton = SubButton(title: "Edit commands")
  
  private let menuButtonAtTopPage: SubButton = SubButton(title: "Menu")
  
  private lazy var verticalSV: VerticalStackView = {
    let sv = VerticalStackView(arrangedSubviews: [screenTitle, buttonWrapper])
    sv.alignment = .fill
    sv.distribution = .equalSpacing
    return sv
  }()
  
  private let heartDemoButton = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    GameManager.shared.resetGameManeger()
    
    configureLayout()
    backgroundCreator.configureLayout()
    
    configureBindings()
    
    configureDemoButton() // debug button
  }
}


// MARK: - Layout

extension TopViewController {
  
  private func configureLayout() {
    
    verticalSV.configureSuperView(under: view)
    
    // Set constraints
    verticalSV.matchParent(
      padding: .init(
        top: Constant.Common.topSpacing,
        left: Constant.Common.leadingSpacing,
        bottom: Constant.Common.bottomSpacing,
        right: Constant.Common.trailingSpacing
      )
    )
    
    startButton.insertIcon(
      IconFactory.createSystemIcon(
        "arrowtriangle.right.fill",
        color: CustomColor.background,
        pointSize: 14
      ),
      to: .left
    )
    
    configureButtonLayout()
  }
  
  private func configureButtonLayout() {
    let image = IconFactory.createImage(type: .levelOne, width: 28)
    editCommandButton.insertIcon(
      image.withTintColor(CustomColor.text, renderingMode: .alwaysOriginal),
      to: .left
    )
    editCommandButton.contentEdgeInsets.left -= 10.5
    editCommandButton.backgroundColor = .clear
    
    menuButtonAtTopPage.insertIcon(
      IconFactory.createSystemIcon("list.bullet", pointSize: 15 ),
      to: .left
    )
    menuButtonAtTopPage.contentEdgeInsets.left -= 9
    menuButtonAtTopPage.backgroundColor = .clear
  }
  
}

// MARK: - Bindings

extension TopViewController {

  private func configureBindings() {
    startButton.rx
      .tap
      .bind { [weak self] _ in
        guard let self = self else { return }
        let nx = PlayerSelectionViewController()
        Vibration.impact()
        GameManager.shared.pushGameProgress(
          navVC: self.navigationController,
          currentScreen: self,
          nextScreen: nx
        )
      }
      .disposed(by: disposeBag)
    
    editCommandButton.rx
      .tap
      .bind { [weak self] _ in
        guard let self = self else { return }
        let nx = CommandSettingViewController()
        Vibration.confirm()
        self.navigationController?.pushViewController(nx, animated: true)
      }
      .disposed(by: disposeBag)
    
    menuButtonAtTopPage.rx
      .tap
      .bind { [weak self] _ in
        guard let self = self else { return }
        let nx = MenuViewController()
        nx.viewModel.isTopMenu = true
        nx.modalPresentationStyle = .overCurrentContext
        nx.transitioningDelegate = self.popUpTransitioning
        Vibration.confirm()
        
        // If already something is presented, present the view over it
        if let presentedVC = self.presentedViewController {
            presentedVC.present(nx, animated: true, completion: nil)
        }else{
          self.present(nx, animated: true, completion: nil)
        }
      }
      .disposed(by: disposeBag)

  }
  
}


// MARK: - Debug button.

extension TopViewController {
  
  private func configureDemoButton() {
    
    // Set image
    let btImage = IconFactory.createSystemIcon(
      "heart.fill",
      color: CustomColor.accent,
      pointSize: 40
    )
    heartDemoButton.setImage(btImage, for: .normal)
    heartDemoButton.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/4.8))
    
    // constraint
    heartDemoButton.configureSuperView(under: view)
    NSLayoutConstraint.activate([
      heartDemoButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 80),
      heartDemoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48)
    ])
    
    if !Constant.isDebugMode {
      heartDemoButton.isUserInteractionEnabled = false
      return
    }
    
    heartDemoButton.rx
      .tap
      .bind { [weak self] _ in
        guard let self = self else { return }
        self.navigationController?.pushViewController(
          DemoViewController(),
          animated: true
        )
      }
      .disposed(by: disposeBag)
  }
  
}
