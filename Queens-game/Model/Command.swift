//
//  Command.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-05.
//

import Foundation
import RealmSwift

/// Command object capable in realm
class Command: Object {
  @objc dynamic let id: UUID = UUID()
  @objc dynamic var detail: String = ""
  // Don't allow access by int
  @objc private dynamic var intDifficulty: Int = 0
  // Don't allow access by int
  @objc private dynamic var intType: Int = 0
  
  // What do you want to use as primaryKey?
  override class func primaryKey() -> String? {
    return "id"
  }
}


// MARK: - Getter and Setter of enum type

extension Command {
  /// Get and Set `Difficulty` by enum type
  var difficulty: Difficulty {
    get {
      return Difficulty(rawValue: intDifficulty) ?? .easy
    }
    set {
      let intValue = newValue.rawValue
      if intValue >= 0 && intValue <= Difficulty.count{
        intDifficulty = intValue
      }
    }
  }
  
  /// Get and Set `CommandType` by enum type
  var type: CommandType {
    get {
      return CommandType(rawValue: intType) ?? .cToC
    }
    set {
      let intValue = newValue.rawValue
      if intValue >= 0 && intValue <= CommandType.count{
        intType = intValue
      }
    }
  }
}
