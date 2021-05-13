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

  let canSkipOrderSelectionRelay = PublishRelay<Bool>()

  let queenWaitingSecondsRelay = PublishRelay<Double>()

  let citizenWaitingSecondsRelay = PublishRelay<Double>()

  lazy var skipRelays = [self.canSkipQueenSelectionRelay, self.canSkipOrderSelectionRelay]

  lazy var waitingRelays = [self.queenWaitingSecondsRelay, self.citizenWaitingSecondsRelay]

  init(settings: SettingsProtocol) {
    self.settings = settings

    // RxSwift
    self.canSkipQueenSelectionRelay.subscribe { [weak self] in
      self?.settings.updateSkipQueenSelection($0)
    }.disposed(by: disposeBag)

    self.canSkipOrderSelectionRelay.subscribe { [weak self]  in
      self?.settings.updateSkipOrderSelection($0)
    }.disposed(by: disposeBag)

    self.queenWaitingSecondsRelay.subscribe { [weak self] sec in
      self?.settings.updateQueenSelectionWaitingSeconds(sec: sec)
    }.disposed(by: disposeBag)

    self.citizenWaitingSecondsRelay.subscribe { [weak self] sec in
      self?.settings.updateCitizenSelectionWaitingSeconds(sec: sec)
    }.disposed(by: disposeBag)

    _ = Observable
      .combineLatest(
        canSkipOrderSelectionRelay,
        canSkipQueenSelectionRelay,
        queenWaitingSecondsRelay,
        citizenWaitingSecondsRelay
      )
      .subscribe(onNext: { value in
        self.settings.saveByMySelf()
      })
      .disposed(by: disposeBag)

  }

}
