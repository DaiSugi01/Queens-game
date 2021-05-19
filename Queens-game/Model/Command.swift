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
  
  @objc dynamic var id: String = UUID().uuidString
  @objc dynamic var detail: String = ""
  // Don't allow access by int
  @objc private dynamic var intDifficulty: Int = 0
  // Don't allow access by int
  @objc private dynamic var intType: Int = 0
  
  
  // What do you want to use as primaryKey?
  override class func primaryKey() -> String? {
    return "id"
  }
  
  convenience init(
    detail: String = "",
    difficulty: Difficulty = .easy,
    commandType: CommandType = .cToC
  ) {
    self.init()
    self.detail = detail
    self.difficulty = difficulty
    self.commandType = commandType
  }

}


// MARK: - Getter and Setter for enum type

extension Command {
  /// Get and Set `Difficulty`
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
  
  /// Get and Set `CommandType`
  var commandType: CommandType {
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


// MARK: - Getter for Icon Type

extension Command {
  /// Get `IconType`from `CommandType`
  var commandIconType: IconType {
    get {
      switch CommandType(rawValue: intType) {
        case .cToA:
          return .cToA
        case .cToC:
          return .cToC
        case .cToQ:
          return .cToQ
        default:
          return .cToC
      }
    }
  }
  
  /// Get `IconType`from `DifficultyType`
  var difficultyIconType: IconType {
    get {
      switch Difficulty(rawValue: intDifficulty) {
        case .easy:
          return .levelOne
        case .normal:
          return .levelTwo
        case .hard:
          return .levelThree
        default:
          return .levelOne
      }
    }
  }
}

// MARK: - Getter for description

extension Command {
  /// Get description for `CommandType`
  var commandTypeDescription: String {
    get {
      switch CommandType(rawValue: intType) {
        case .cToA:
          return Constant.CommandDescription.cToA
        case .cToC:
          return Constant.CommandDescription.cToC
        case .cToQ:
          return Constant.CommandDescription.cToQ
        default:
          return Constant.CommandDescription.cToC
      }
    }
  }
  
  /// Get description for `Difficulty`
  var difficultyDescription: String {
    get {
      switch Difficulty(rawValue: intDifficulty) {
        case .easy:
          return Constant.CommandDescription.easy
        case .normal:
          return Constant.CommandDescription.normal
        case .hard:
          return Constant.CommandDescription.hard
        default:
          return Constant.CommandDescription.easy
      }
    }
  }
}
