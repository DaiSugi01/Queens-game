//
//  SectionItem.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-26.
//

import Foundation

// MARK: - Demo Section
/// ⚠️ Fake Section of enum used for diffable data source. Do not use in the release version.
enum DemoSection: Hashable {
  case userName
  case command
  case selection
}

// MARK: - Demo Item
/// ⚠️ Fake Item of enum used for diffable data source. Do not use in the release version.
enum DemoItem: Hashable {
  case user(DemoUser)
  case command(DemoCommand)
  case selection(DemoSelection)
}

// User
extension DemoItem {
  /// Get User model from Item
  var user: DemoUser? {
    if case let .user(u) = self {
      return u
    } else {
      return nil
    }
  }
  /// Wrap User model into Item
  static func wrapUser(items: [DemoUser]) -> [DemoItem] {
    return items.map {DemoItem.user($0)}
  }
}

// Command
extension DemoItem {
  /// Get Command model from Item
  var command: DemoCommand? {
    if case let .command(c) = self {
      return c
    } else {
      return nil
    }
  }
  /// Wrap Command model into Item
  static func wrapCommand(items: [DemoCommand]) -> [DemoItem] {
    return items.map {DemoItem.command($0)}
  }
}

// Selection
extension DemoItem {
  /// Get Selection model from Item
  var selection: DemoSelection? {
    if case let .selection(o) = self {
      return o
    } else {
      return nil
    }
  }
  /// Wrap Selection model into Item
  static func wrapSelection(items: [DemoSelection]) -> [DemoItem] {
    return items.map {DemoItem.selection($0)}
  }
}
