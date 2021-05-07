//
//  User.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-05.
//

import Foundation

struct User {
  let id: UUID
  let playerId: Int
  var name: String
  var isQueen: Bool = false
}

// This makes `User` usabel in snapshot.
extension User: Hashable { }
