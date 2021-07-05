//
//  PlayerSelectionViewModel.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/05/14.
//

import Foundation
import RxSwift
import RxRelay


class PlayerSelectionViewModel {
  
  let numOfPlayers: BehaviorRelay = BehaviorRelay(value: Constant.PlayerSelection.defaultPlayerCount)
  
  let disposeBag = DisposeBag()
  
  /// initialize user data
  /// - Parameter playerCount: the number of players
  func initUserData(playerCount: Int) {
    GameManager.shared.users.removeAll()
    for id in 1 ... playerCount {
      GameManager.shared.users.append(
        User(
          id: UUID(),
          playerId: id,
          name: "Player\(id)"
        )
      )
    }
  }
}
