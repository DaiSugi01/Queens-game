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
  var countdownTime = Int(Settings.shared.citizenWaitingSeconds)

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
        if self?.countdownTime == -1 {
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

// Suits anmation
// Completely redundant... just for fun.
extension CitizenSelectedViewModel {
  func rotateSuite(time: Int, view: UIView?) {
    guard let countDownView = view as? CountdownGroup else { return }
    var targetSuit: UIImageView?
    switch (Int(Settings.shared.citizenWaitingSeconds) - time - 1)%4 {
      case 0:
        targetSuit = countDownView.spadeSuit
      case 1:
        targetSuit = countDownView.heartSuit
      case 2:
        targetSuit = countDownView.clubSuit
      case 3:
        targetSuit = countDownView.diamondSuit
      default:
        targetSuit = countDownView.spadeSuit
    }

    guard let targetSuit = targetSuit else { return }
    rotate(view: targetSuit)
  }
  
  private func rotate(view: UIView) {
    let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
    rotation.toValue = NSNumber(value: Double.pi * 2)
    rotation.duration = 0.8
    rotation.isCumulative = true
    rotation.repeatCount = 1
    rotation.timingFunction = CAMediaTimingFunction(name: .easeOut)
    view.layer.add(rotation, forKey: "rotationAnimation")
  }
}
