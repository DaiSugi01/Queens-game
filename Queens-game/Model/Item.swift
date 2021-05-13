//
//  Item.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-05.
//

import Foundation

/// Item of enum used for diffable data source.
enum Item: Hashable {
  /// This item is used for collection view when inputting user name such as `EntryNameViewController`
  case user(User)
  /// This item is used for collection view when accessing command such as  `CommandSettingViewController` and `CommandManualSelectingViewController`
  case command(Command)
  /// This item is used for collection view when selecting choices such as `QueenSelectionViewController` and `CommandSelectionViewController`
  case selection(Selection)
}


// MARK: - Getter and wrapper

// User
extension Item {
  /// Get `User` model from Item
  var user: User? {
    get {
      if case let .user(u) = self {
        return u
      } else {
        return nil
      }
    }
  }
  /// Wrap multi User model into Items
  static func wrap(items: [User]) -> [Item] {
    return items.map {Item.user($0)}
  }
}

// Command
extension Item {
  /// Get Command model from Item
  var command: Command? {
    if case let .command(c) = self {
      return c
    } else {
      return nil
    }
  }
  /// Wrap multi Command model into Items
  static func wrap(items: [Command]) -> [Item] {
    return items.map {Item.command($0)}
  }
  
}

// Selection
extension Item {
  /// Get Selection model from Item
  var selection: Selection? {
    if case let .selection(o) = self {
      return o
    } else {
      return nil
    }
  }
  /// Wrap multi Selection model into Items
  static func wrap(items: [Selection]) -> [Item] {
    return items.map {Item.selection($0)}
  }
}
