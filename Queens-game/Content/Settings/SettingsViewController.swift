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
  let switchQueenSelection = SettingsSwitcherStackView()
  let switchCommandSelection = SettingsSwitcherStackView()
  let waitingTimeQueenSelection = SettingsWaitingTimeStackView()
  let waitingTimeCommandSelection = SettingsWaitingTimeStackView()
  
  lazy var items = [
    switchQueenSelection,
    switchCommandSelection,
    waitingTimeQueenSelection,
    waitingTimeCommandSelection
  ]
  
  lazy var contentView = VerticalStackView(
    arrangedSubviews: [titleLabel] + items
  )
  
  lazy var scrollView =  DynamicHeightScrollView(
    contentView: contentView,
    padding: .init(
      top: Constant.Common.topSpacing,
      left: Constant.Common.leadingSpacing,
      bottom: Constant.Common.bottomSpacing,
      right: Constant.Common.trailingSpacing
    )
  )
  
  override func viewDidLoad() {
    super.viewDidLoad()
    backgroundCreator.configureLayout()
    setupLayout()
    configureBinding()
    
  }
  
}

extension SettingsViewController {
  
  private func setupLayout() {
    view.configBgColor(bgColor: CustomColor.background)
    scrollView.configSuperView(under: view)
    scrollView.matchParent()
  }
  
  private func configureBinding() {
    items.enumerated().forEach { (index, item) in
      if let switchItem = item as? SettingsSwitcherStackView {
        let row = self.viewModel.settings.skipSettings()
        switchItem.descriptionLabel.text = row[index].description
        switchItem.switcher.setOn(row[index].canSkip, animated: false)
        
        // RxSwift
        let relay = self.viewModel.skipRelays[index]
        switchItem.switcher.rx.isOn.asObservable()
          .subscribe(onNext: {
            relay.accept($0)
          })
          .disposed(by: disposeBag)
      }
      
      if let waitingTimeItem = item as? SettingsWaitingTimeStackView {
        
        let index = index/2
        let row = self.viewModel.settings.waitingSeconds()
        waitingTimeItem.descriptionLabel.text = row[index].description
        let sec = row[index].sec
        waitingTimeItem.stepper.value = sec
        waitingTimeItem.sec.text = "\(Int(sec)) sec"
        
        // RxSwift
        let relay = self.viewModel.waitingRelays[index]
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

