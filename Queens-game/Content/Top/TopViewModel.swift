//
//  TopViewModel.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/05/09.
//

import Foundation

class TopViewModel {
  init() {
  }
  
  public func resetGameManeger() {
    GameManager.shared.users = []
    GameManager.shared.queen = nil
    GameManager.shared.gameProgress = 0
  }
}
