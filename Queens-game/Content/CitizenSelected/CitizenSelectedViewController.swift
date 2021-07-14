//
//  CitizenSelectedViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit
import RxSwift
import RxCocoa

class CitizenSelectedViewController:  UIViewController, QueensGameViewControllerProtocol {
  
  lazy var backgroundCreator: BackgroundCreator = BackgroundCreatorPlain(parentView: view)

  private let disposeBag = DisposeBag()

  private let viewModel = CitizenSelectedViewModel()

  
  // MARK: - Before count down stack view
  
  private lazy var countdownStackView = CountdownStackView(
    countdown: viewModel.countdownTime
  )

  private let beforeCountdownTitle: H2Label = {
    let lb = H2Label(text: "Choosing citizens...")
    lb.lineBreakMode = .byWordWrapping
    lb.setContentHuggingPriority(.required, for: .vertical)
    lb.textAlignment = .center
    return lb
  }()

  private let skipButton: SubButton = {
    let button = SubButton()
    button.setTitle("Skip", for: .normal)
    button.insertIcon(IconFactory.createSystemIcon("chevron.right.2", weight: .bold), to: .right)
    return button
  }()

  private lazy var beforeCountdownStackView: VerticalStackView = {
    let sv = VerticalStackView(
      arrangedSubviews: [
        beforeCountdownTitle,
        countdownStackView,
        skipButton
      ]
    )
    sv.alignment = .center
    sv.distribution = .equalSpacing
    return sv
  }()

  
  // MARK: After Countdown views

  private let afterCountdownTitle: H2Label = {
    let lb = H2Label(text: "Target")
    lb.lineBreakMode = .byWordWrapping
    lb.setContentHuggingPriority(.required, for: .vertical)
    return lb
  }()

  private lazy var targetUserIcon: UIImageView = createLargeUserIcon(id: viewModel.target.playerId)

  private lazy var targetUserName: H3Label = {
    let label = H3Label(text: viewModel.target.name)
    label.textAlignment = .center
    return label
  }()
  
  private lazy var targetWrapper: VerticalStackView = {
    let stackView = VerticalStackView(
      arrangedSubviews: [targetUserIcon, targetUserName]
    )
    stackView.spacing = 8
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.directionalLayoutMargins.bottom = 24
    return stackView
  }()


  // We will insert stakeHolder views into here, if c to c which needs one more icon
  private lazy var commandWrapper: VerticalStackView = {
    let stackView = VerticalStackView(
      arrangedSubviews: [targetWrapper],
      alignment: .center
    )
    stackView.spacing = 40
    return stackView
  }()
  
  private let nextButton: MainButton = {
    let button = MainButton()
    button.setTitle("Next", for: .normal)
    button.isEnabled = false
    return button
  }()

  private lazy var afterCountdownStackView: VerticalStackView = {
    let stackView = VerticalStackView(
      arrangedSubviews: [
        afterCountdownTitle,
        commandWrapper,
        nextButton
      ],
      alignment: .center,
      distribution: .equalSpacing
    )
    return stackView
  }()
  
  
  // MARK: - Stakeholder views (this is used for "c to c" command)

  private lazy var stakeholderIcon: UIImageView = createLargeUserIcon(id: viewModel.stakeholder.playerId)

  private lazy var stakeholderName: H3Label = {
    let label = H3Label(text: viewModel.stakeholder.name)
    label.textAlignment = .center
    return label
  }()

  private lazy var stakeholderStackView: VerticalStackView = {
    let stackView = VerticalStackView(
      arrangedSubviews: [stakeholderIcon, stakeholderName]
    )
    stackView.spacing = 8
    return stackView
  }()
  

  override func viewDidLoad() {
    super.viewDidLoad()
    backgroundCreator.configureLayout()
    configureLayoutBeforeCountdown()
    configureNavButtonBinding()
    
    if viewModel.settings.canSkipCommand {
      replaceView()
      return
    }
    viewModel.countdown()
    configureCountdownBinding()

  }
}


// MARK: - Layut

extension CitizenSelectedViewController {

  private func configureLayoutBeforeCountdown() {
    
    beforeCountdownStackView.configureSuperView(under: super.view)
    beforeCountdownStackView.matchParent(
      padding: .init(
        top: Constant.Common.topSpacing,
        left: Constant.Common.leadingSpacing,
        bottom: Constant.Common.bottomSpacing,
        right: Constant.Common.trailingSpacing
      )
    )
    
  }

  private func replaceView() {
    self.beforeCountdownStackView.removeFromSuperview()
    
    // Set up, but make last half views invisible
    afterCountdownStackView.alpha = 0
    self.configureLayoutAfterCountdown()
    
    // Fade in the last half views
    UIView.animate(
      withDuration: 1.8,
      delay: 0,
      options: .curveEaseIn,
      animations: {
        self.afterCountdownStackView.alpha = 1
      },
      completion: { _ in
        self.nextButton.isEnabled = true
      }
    )
  }
  
  private func configureLayoutAfterCountdown() {
    
    afterCountdownStackView.configureSuperView(under: super.view)
    afterCountdownStackView.matchParent(
      padding: .init(
        top: Constant.Common.topSpacing,
        left: Constant.Common.leadingSpacing,
        bottom: Constant.Common.bottomSpacing,
        right: Constant.Common.trailingSpacing
      )
    )

    if viewModel.getGameManager().command.commandType == .cToC {
      commandWrapper.addArrangedSubview(stakeholderStackView)
      afterCountdownTitle.text = "Targets"
    }

  }
  
  private func createLargeUserIcon(id: Int) -> UIImageView {
    let isTwoIcon = viewModel.getGameManager().command.commandType == .cToC
    
    let idIcon = IconFactory.createImageView(
      type: .userId(id),
      width: isTwoIcon ? 112 : 152
    ) as! UserIdIconView
    idIcon.label.font = CustomFont.h2.withSize(isTwoIcon ? 48 : 64)
    idIcon.configureRadius(radius: (isTwoIcon ? 112 : 152)/4)
    return idIcon
  }

}


// MARK: - Binding

extension CitizenSelectedViewController {
  
  private func configureNavButtonBinding() {
    skipButton.rx
      .tap
      .bind { [weak self] _ in
        self?.viewModel.rxCountdownTime.onCompleted()
      }
      .disposed(by: disposeBag)
    
    nextButton.rx
      .tap
      .bind { [weak self] _ in
        guard let self = self else { return }
        let nx = ResultViewController(
          target:self.viewModel.target,
          stakeholders:self.viewModel.stakeholders
        )
        
        GameManager.shared.pushGameProgress(
          navVC: self.navigationController,
          currentScreen: self,
          nextScreen: nx
        )
      }
      .disposed(by: disposeBag)
  }
  
  private func configureCountdownBinding() {
    viewModel.rxCountdownTime
      .subscribe(onNext: { [weak self] time in
        guard let time = time else { return }
        DispatchQueue.main.async {
          self?.countdownStackView.countdownLabel.text = String(time)
          self?.viewModel.rotateSuite(time: time, view: self?.countdownStackView)
        }
      },
      onCompleted: {
        self.replaceView()
      })
      .disposed(by: disposeBag)
  }
}
