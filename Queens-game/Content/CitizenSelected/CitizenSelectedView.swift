//
//  CitizenSelectedView.swift
//  Queens-game
//
//  Created by Takayasu Nasu on 2021/05/14.
//

import Foundation
import RxSwift
import RxCocoa

class CitizenSelectedViewModel {

  var timer = Timer()

  lazy var executor = self.createExecutor(self.getGameManager())

  let rxCountdownTime = PublishSubject<Int?>()
  var countdonwTime = Int(Settings.shared.citizenSelectionWaitingSeconds)

  func countdown() {
    self.timer = Timer.scheduledTimer(
      withTimeInterval: 1,
      repeats: true,
      block: { [weak self] timer in
        self?.countdonwTime -= 1
        self?.rxCountdownTime.onNext(self?.countdonwTime)
        if self?.countdonwTime == 0 {
          self?.rxCountdownTime.onCompleted()
        }
      })
  }

  private func createExecutor(_ gameManager: GameManagerProtocol) -> ExecutorProtocol {
    switch gameManager.command.commandType {
    case .cToC:
      return ExecutorCtoC()
    case .cToA:
      return ExecutorCtoA()
    case .cToQ:
      return ExecutorCtoQ()
    }
  }

  func getGameManager() -> GameManagerProtocol {
    if GameManager.shared.users.count > 0 {
      return GameManager.shared
    } else {
      return MockGameManager()
    }
  }
}
