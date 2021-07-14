//
//  QueenReadyForSelectionViewController.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-07-10.
//

import UIKit
import RxSwift
import RxCocoa

class QueenBeforeSelectionViewController:
  UIViewController,
  QueensGameViewControllerProtocol
{
  lazy var backgroundCreator: BackgroundCreator = BackgroundCreatorWithMenu(viewController: self)
  
  private let viewModel = QueenBeforeSelectionViewModel()
  
  private let screenTitle: H2Label = {
    let lb = H2Label(text: "Let's decide the Queen!")
    lb.setContentHuggingPriority(.required, for: .vertical)
    lb.textAlignment = .center
    return lb
  }()
  
  private let backButton: SubButton = {
    let button = SubButton()
    button.setTitle("Back", for: .normal)
    return button
  }()
  
  private let tapButtonShadow: UIImageView = {
    
    let image = IconFactory.createImage(
      type: .queen,
      width: UIScreen.main.bounds.width*0.40
    )
    let imgv = UIImageView(image: image)
    return imgv
  }()
  
  private let tapButton: UIButton = {
    let bt = UIButton()
    
    let image = IconFactory.createImage(
      type: .queen,
      width: UIScreen.main.bounds.width*0.40
    )
    bt.setImage(image, for: .normal)
    bt.setImage(image, for: .highlighted)
    
    let bgImage = IconFactory.createSystemIcon(
      "circle",
      color: CustomColor.backgroundLower,
      pointSize: UIScreen.main.bounds.width*0.52,
      weight: .light,
      scale: .default
    )
    bt.setBackgroundImage(bgImage, for: .normal)
    bt.setBackgroundImage(bgImage, for: .highlighted)
    return bt
  }()
  
  private let tapDescription: PLabel = {
    let lb = PLabel(text: "Tap to decide the queen!")
    lb.tintColor  = CustomColor.subText.withAlphaComponent(0.6)
    lb.textAlignment = .center
    return lb
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureSuperViews()
    configureConstraints()
    backgroundCreator.configureLayout()
    
    configureBindings()

  }
  
}


// MARK: - Layout

extension QueenBeforeSelectionViewController {
  private func configureSuperViews() {
    screenTitle.configureSuperView(under: view)
    tapButtonShadow.configureSuperView(under: view)
    tapButton.configureSuperView(under: view)
    tapDescription.configureSuperView(under: view)
    backButton.configureSuperView(under: view)
  }
  
  private func configureConstraints() {
    screenTitle.anchors(
      topAnchor: view.topAnchor,
      leadingAnchor: view.leadingAnchor,
      trailingAnchor: view.trailingAnchor,
      bottomAnchor: nil,
      padding: .init(
        top: Constant.Common.topSpacing,
        left: Constant.Common.leadingSpacing,
        bottom: 0,
        right: Constant.Common.trailingSpacing
      )
    )
    
    tapButtonShadow.centerXYin(view)
    tapButton.centerXYin(view)
    tapDescription.constraintWidth(equalToConstant: 160)
    tapDescription.centerXin(view)
    tapDescription.topAnchor.constraint(
      equalTo: tapButton.bottomAnchor,
      constant: 4
    ).isActive = true
    
    NSLayoutConstraint.activate([
      backButton.bottomAnchor.constraint(
        equalTo: view.bottomAnchor,
        constant: -Constant.Common.bottomSpacing
      ),
      backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
  }
}


// MARK: - Bindings

extension QueenBeforeSelectionViewController {
  private func configureBindings() {
    backButton.rx
      .tap
      .bind { [weak self] _ in
        GameManager.shared.popGameProgress(navVC: self?.navigationController!)
      }
      .disposed(by: viewModel.disposeBag)
    
    tapButton.rx
      .tap
      .bind {  _ in
        DispatchQueue.main.async { [weak self] in
          self?.transitToNextView()
        }
      }
      .disposed(by: viewModel.disposeBag)
  }
  
  private func transitToNextView() {
      // prevent multi tapping
      self.tapButton.isUserInteractionEnabled = false
      
    Vibration.impact()
    
      UIView.animate(
        withDuration: 0.4,
        delay: 0,
        options: [.curveEaseOut],
        animations: {
          self.tapButtonShadow.transform = CGAffineTransform(scaleX: 1.24, y: 1.24)
          self.tapButtonShadow.alpha = 0
        },
        completion: { _ in
          // Transition
          self.viewModel.selectQueen()
          let nx = QueenSelectedViewController()
          GameManager.shared.pushGameProgress(
            navVC: self.navigationController,
            currentScreen: self,
            nextScreen: nx
          )
          
          // Reset animation and button
          self.tapButtonShadow.transform = .identity
          self.tapButtonShadow.alpha = 1
          self.tapButton.isUserInteractionEnabled = true
        }
      )
  }
  
}
