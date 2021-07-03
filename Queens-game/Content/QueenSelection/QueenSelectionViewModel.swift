//
//  QueenSelectionViewModel.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/05/11.
//

import Foundation
import RxSwift

class QueenSelectionViewModel {
  
  let disposeBag = DisposeBag()
  
  public func selectQueen() {
    let queenIndex: Int = Int.random(in: 0 ..< GameManager.shared.users.count)
    let queen = GameManager.shared.users[queenIndex]
    GameManager.shared.queen = queen
  }
}
