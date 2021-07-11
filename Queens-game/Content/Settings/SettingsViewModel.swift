//
//  SettingsViewModel.swift
//  Queens-game
//
//  Created by Takayasu Nasu on 2021/05/09.
//

import Foundation
import RxSwift
import RxCocoa

class SettingViewModel {

  let disposeBag = DisposeBag()

  var settings: SettingsProtocol

  let canSkipQueenSelectionRelay = PublishRelay<Bool>()

  let canSkipCommandSelectionRelay = PublishRelay<Bool>()

  let queenWaitingSecondsRelay = PublishRelay<Double>()

  let citizenWaitingSecondsRelay = PublishRelay<Double>()
  
  
  /// Get `PublishRelay` related to `canSkip` type item in setting
  /// - Parameter identifier: item id
  /// - Returns: `PublishRelay` related to `canSkip` type item in setting
  func getCanSkipRelay(_ type: canSkip) ->  PublishRelay<Bool> {
    switch type {
      case .queen:
        return self.canSkipQueenSelectionRelay
      case .command:
        return self.canSkipCommandSelectionRelay
    }
  }
  
  /// Get `PublishRelay` related to `waitingSeconds` type item in setting
  /// - Parameter identifier: item id
  /// - Returns: `PublishRelay` related to `waitingSeconds` type item in setting
  func getWaitingSecondsRelay(_ type: WaitingSeconds) ->  PublishRelay<Double> {
    switch type {
      case .queen:
        return self.queenWaitingSecondsRelay
      case .citizen:
        return self.citizenWaitingSecondsRelay
    }
  }

  init(settings: SettingsProtocol) {
    self.settings = settings

    // RxSwift
    self.canSkipQueenSelectionRelay.subscribe { [weak self] in
      self?.settings.updateSkipQueenSelection($0)
    }.disposed(by: disposeBag)

    self.canSkipCommandSelectionRelay.subscribe { [weak self]  in
      self?.settings.updateSkipCommandSelection($0)
    }.disposed(by: disposeBag)

    self.queenWaitingSecondsRelay.subscribe { [weak self] sec in
      self?.settings.updateQueenSelectionWaitingSeconds(sec: sec)
    }.disposed(by: disposeBag)

    self.citizenWaitingSecondsRelay.subscribe { [weak self] sec in
      self?.settings.updateCitizenSelectionWaitingSeconds(sec: sec)
    }.disposed(by: disposeBag)

    _ = Observable
      .combineLatest(
        canSkipCommandSelectionRelay,
        canSkipQueenSelectionRelay,
        queenWaitingSecondsRelay,
        citizenWaitingSecondsRelay
      )
      .skip(1)
      .subscribe(onNext: { value in
        self.settings.saveByMySelf()
      })
      .disposed(by: disposeBag)

  }

}
