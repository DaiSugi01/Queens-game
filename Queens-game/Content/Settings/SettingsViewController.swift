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
  let canSkipQueenView = SettingsSwitcherStackView(.queen)
  let canSkipCommandView = SettingsSwitcherStackView(.command)
  let queenWaitingSecondsView = SettingsWaitingTimeStackView(.queen)
  let citizenWaitingSecondsView = SettingsWaitingTimeStackView(.citizen)
  
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
    view.configureBgColor(bgColor: CustomColor.background)
    
    scrollView.configureSuperView(under: view)
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
      // Switch
      if let switchItem = item as? SettingsSwitcherStackView {
        
        let switchType = switchItem.type ?? .queen
        
        // fill data
        let data = self.viewModel.settings.getCanSkipSource(switchType)
        switchItem.descriptionLabel.text = data.description
        switchItem.switcher.setOn(data.canSkip, animated: false)
        
        // bind
        switchItem.switcher.rx.isOn.asObservable()
          .subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            
            // to setting
            self.viewModel.getCanSkipRelay(switchType).accept($0)
            // to waiting seconds view
            let isOff = !$0
            switch switchType {
              case .queen:
                self.queenWaitingSecondsView.isUserInteractionEnabled = isOff
                self.queenWaitingSecondsView.alpha = isOff ?  1.0 : 0.2
              case .command:
                self.citizenWaitingSecondsView.isUserInteractionEnabled = isOff
                self.citizenWaitingSecondsView.alpha = isOff ?  1.0 : 0.2
            }
            
          })
          .disposed(by: disposeBag)
      }
      
      // Sec
      if let waitingTimeItem = item as? SettingsWaitingTimeStackView {
        let data = self.viewModel.settings.getWaitingSecondsSource(waitingTimeItem.type)
        waitingTimeItem.descriptionLabel.text = data.description
        let sec = data.sec
        waitingTimeItem.stepper.value = sec
        waitingTimeItem.sec.text = "\(Int(sec)) sec"

        let relay = self.viewModel.getWaitingSecondsRelay(waitingTimeItem.type)

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

