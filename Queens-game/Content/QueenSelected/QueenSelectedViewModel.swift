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
  
  var settings = Settings.shared

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


// Completely redundant... just for fun.
extension QueenSelectedViewModel {
  func rotateSuite(time: Int, view: UIView?) {
    guard let countDownView = view as? CountdownGroup else { return }
    
    var targetSuit: UIImageView?
    switch (Int(Settings.shared.queenWaitingSeconds) - time - 1)%4 {
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
