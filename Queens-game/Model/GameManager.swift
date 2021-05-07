//
//  GameManager.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-05.
//

import Foundation

class GameManager {
  private init() {}
  static let shared = GameManager()
  
  var users: [User] = []
  var queen: User?
  var gameProgress: Int = 0
}
