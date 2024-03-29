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
}

// This makes `User` hashabel in snapshot.
extension User: Hashable { }

// This makes `User` codabel in UserDefaults.
extension User: Codable { }
