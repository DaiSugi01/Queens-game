//
//  Executor.swift
//  Queens-game
//
//  Created by Takayasu Nasu on 2021/05/15.
//

import Foundation

protocol ExecutorProtocol {

  func select(from gameManager: GameManagerProtocol) -> (User, [User])

}

extension ExecutorProtocol {

  func removeQueen(from gameManager: GameManagerProtocol) -> [User] {
    return gameManager.users.filter { user in
      return !user.isQueen
    }
  }
}

/// - ExecutorCtoC
///   - only one stakeholder.
/// - ExecutorCtoA
///   - all players are stakeholder except target.
/// - ExecutorCtoQ
///    - stakeholder is queen.
struct ExecutorCtoC: ExecutorProtocol {

  func select(from gameManager: GameManagerProtocol) -> (User, [User]) {
    var players = self.removeQueen(from: gameManager).shuffled()
    let target = players.removeLast()
    return (target, [players.removeLast()])
  }
}

struct ExecutorCtoA: ExecutorProtocol {
  func select(from gameManager: GameManagerProtocol) -> (User, [User]) {
    var players = self.removeQueen(from: gameManager).shuffled()
    let target = players.removeLast()
    return (target, players)
  }
}

struct ExecutorCtoQ: ExecutorProtocol {
  func select(from gameManager: GameManagerProtocol) -> (User, [User]) {
    var players = self.removeQueen(from: gameManager).shuffled()
    let target = players.removeLast()
    return (target, [gameManager.queen!])
  }
}
