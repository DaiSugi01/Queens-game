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

  var settings = Settings.shared

  var target = User(id: UUID(), playerId: 0, name: "")

  var stakeholders = [User(id: UUID(), playerId: 0, name: "")]

  var stakeholder: User = User(id: UUID(), playerId: 0, name: "")

  let rxCountdownTime = PublishSubject<Int?>()
  var countdownTime = Int(Settings.shared.citizenSelectionWaitingSeconds)

  init() {
    (self.target, self.stakeholders) = self.executor.select(from: self.getGameManager())
    self.stakeholder = self.stakeholders[0]
  }

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
