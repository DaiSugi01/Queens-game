//
//  QueenSelectionViewModel.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/05/11.
//

import Foundation

class QueenSelectionViewModel {
  
  public func selectQueen() {
    let queenIndex: Int = Int.random(in: 0 ..< GameManager.shared.users.count)
    GameManager.shared.users[queenIndex].isQueen = true
    let queen = GameManager.shared.users[queenIndex]
    GameManager.shared.queen = queen
  }
}
