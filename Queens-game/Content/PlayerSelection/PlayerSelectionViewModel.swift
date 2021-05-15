//
//  PlayerSelectionViewModel.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/05/14.
//

import Foundation

class PlayerSelectionViewModel {
  
  /// initialize user data
  /// - Parameter playerCount: the number of players
  func initUserData(playerCount: Int) {
    GameManager.shared.users.removeAll()
    for i in 1 ... playerCount {
      GameManager.shared.users.append(User(id: UUID(),
                                           playerId: i,
                                           name: "Player\(i)")
      )
    }
  }
}
