//
//  QueenSelectedViewModel.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/05/23.
//

import Foundation
import RxSwift
import RxCocoa

class QueenSelectedViewModel {
  
  var timer = Timer()

  let rxCountdownTime = PublishSubject<Int?>()
  var countdownTime = Int(Settings.shared.queenWaitingSeconds)

  func countdown() {
    self.timer = Timer.scheduledTimer(
      withTimeInterval: 1,
      repeats: true,
      block: { [weak self] timer in
        self?.countdownTime -= 1
        self?.rxCountdownTime.onNext(self?.countdownTime)
        if self?.countdownTime == 0 {
          self?.rxCountdownTime.onCompleted()
        }
      })
  }
}
