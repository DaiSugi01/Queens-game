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

struct ExecutorCtoC: ExecutorProtocol {

  func select(from gameManager: GameManagerProtocol) -> (User, [User]) {
    return (User(id: UUID(), playerId: 1, name: ""), [User(id: UUID(), playerId: 1, name: "")])
  }
}

struct ExecutorCtoA: ExecutorProtocol {
  func select(from gameManager: GameManagerProtocol) -> (User, [User]) {
    return (User(id: UUID(), playerId: 1, name: ""), [User(id: UUID(), playerId: 1, name: "")])
  }
}

struct ExecutorCtoQ: ExecutorProtocol {
  func select(from gameManager: GameManagerProtocol) -> (User, [User]) {
    return (User(id: UUID(), playerId: 1, name: ""), [User(id: UUID(), playerId: 1, name: "")])
  }
}
