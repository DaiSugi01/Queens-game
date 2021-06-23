//
//  SettingsViewController.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/04/27.
//

import UIKit
import RxSwift
import RxCocoa

class SettingsViewController: UIViewController, QueensGameViewControllerProtocol {
  lazy var backgroundCreator: BackgroundCreator = BackgroundCreatorWithClose(viewController: self)
  
  let disposeBag = DisposeBag()
  
  let viewModel: SettingViewModel = SettingViewModel(settings: Settings.shared)
  
  let titleLabel = H2Label(text: "Settings")
  let canSkipQueenView = SettingsSwitcherStackView(Settings.canSkipQueenIdentifier)
  let canSkipCommandView = SettingsSwitcherStackView(Settings.canSkipCommandIdentifier)
  let queenWaitingSecondsView = SettingsWaitingTimeStackView(Settings.queenWaitingSecondsIdentifier)
  let citizenWaitingSecondsView = SettingsWaitingTimeStackView(Settings.citizenWaitingSecondsIdentifier)
  
  lazy var items = [
    canSkipQueenView,
    queenWaitingSecondsView,
    canSkipCommandView,
    citizenWaitingSecondsView
  ]
  
  lazy var contentView: VerticalStackView = {
    let sv =  VerticalStackView(
      arrangedSubviews: [titleLabel] + items
    )
    sv.setCustomSpacing(32, after: queenWaitingSecondsView)
    return sv
  } ()
  
  
  lazy var scrollView =  DynamicHeightScrollView(
    contentView: contentView,
    padding: .init(
      top: Constant.Common.topSpacingFromTopLine,
      left: Constant.Common.leadingSpacing,
      bottom: Constant.Common.bottomSpacingFromBottomLine,
      right: Constant.Common.trailingSpacing
    )
  )
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureLayout()
    configureBinding()
    backgroundCreator.configureLayout()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}

extension SettingsViewController {
  
  private func configureLayout() {
    view.configBgColor(bgColor: CustomColor.background)
    
    scrollView.configSuperView(under: view)
    scrollView.matchParent(
      padding: .init(
        top: Constant.Common.topLineHeight,
        left: 0,
        bottom: Constant.Common.bottomLineHeight,
        right: 0
      )
    )
  }
  
  private func configureBinding() {
    items.enumerated().forEach { (index, item) in
      if let switchItem = item as? SettingsSwitcherStackView {
        let data = self.viewModel.settings.getCanSkipSource(switchItem.identifier)
        switchItem.descriptionLabel.text = data.description
        switchItem.switcher.setOn(data.canSkip, animated: false)
        
        // RxSwift
        let relay = self.viewModel.getCanSkipRelay(switchItem.identifier)
        switchItem.switcher.rx.isOn.asObservable()
          .subscribe(onNext: {
            relay.accept($0)
          })
          .disposed(by: disposeBag)
      }
      
      if let waitingTimeItem = item as? SettingsWaitingTimeStackView {
        let data = self.viewModel.settings.getWaitingSecondsSource(waitingTimeItem.identifier)
        waitingTimeItem.descriptionLabel.text = data.description
        let sec = data.sec
        waitingTimeItem.stepper.value = sec
        waitingTimeItem.sec.text = "\(Int(sec)) sec"

        // RxSwift
        let relay = self.viewModel.getWaitingSecondsRelay(waitingTimeItem.identifier)

        waitingTimeItem.stepper.rx.value.asObservable()
          .subscribe(onNext: {
            relay.accept($0)
            waitingTimeItem.sec.text = "\(Int($0)) sec"

          })
          .disposed(by: disposeBag)
      }
      
    }
  }
}

