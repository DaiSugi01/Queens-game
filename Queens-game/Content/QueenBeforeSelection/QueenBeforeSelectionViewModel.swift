//
//  QueenReadyForSelectionViewModel.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-07-10.
//

import RxSwift

class QueenBeforeSelectionViewModel {
  let disposeBag = DisposeBag()
  
  func selectQueen() {
    let queenIndex: Int = Int.random(in: 0 ..< GameManager.shared.users.count)
    let queen = GameManager.shared.users[queenIndex]
    GameManager.shared.queen = queen
  }
}
