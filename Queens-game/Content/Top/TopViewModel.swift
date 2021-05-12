//
//  TopViewModel.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/05/09.
//

import Foundation

class TopViewModel {

  public func resetGameManeger() {
    GameManager.shared.users.removeAll()
    GameManager.shared.queen = nil
    GameManager.shared.gameProgress.removeAll()
  }
}
