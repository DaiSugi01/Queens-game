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
  
  func saveUsers() {
    let jsonEncoder = JSONEncoder()
    guard let users = try? jsonEncoder.encode(GameManager.shared.users) else { return }
    defaults.set(users, forKey: Constant.UserDefaults.users)
    print("a")
  }
  
  func updateUserName(playerId: Int, newName: String) {
    GameManager.shared.users[playerId].name = newName
  }
}
