//
//  EntryNameViewModel.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/05/14.
//

import Foundation
import UIKit

class EntryNameViewModel {
  let defaults: UserDefaults = UserDefaults.standard
  
  /// Get stored user data from user defaults
  func getUsersFromUserDefaults() {
    let jsonDecoder = JSONDecoder()
    guard let data = defaults.data(forKey: Constant.UserDefaults.users),
          let users = try? jsonDecoder.decode([User].self, from: data) else { return }
    
    let playerCount = GameManager.shared.users.count
    for i in 0 ..< playerCount {
      guard users.count > i else { return }
      GameManager.shared.users[i].name = users[i].name
    }
  }
  
  /// Save users to user defaults
  func saveUsers() {
    let jsonEncoder = JSONEncoder()
    guard let users = try? jsonEncoder.encode(GameManager.shared.users) else { return }
    defaults.set(users, forKey: Constant.UserDefaults.users)
  }
  
  /// Update user name
  /// - Parameters:
  ///   - playerId: user player id which is displayed in userId icon - 1
  ///   - newName: user's new name
  func updateUserName(playerId: Int, newName: String) {
    GameManager.shared.users[playerId].name = newName
  }
}
