//
//  Models.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-26.
//

import Foundation

// These are fake models used in demonstrations of UI components. Do not use in the release version.

/// ⚠️ Fake model used in demonstrations of UI components. Do not use in the release version.
enum DemoCommandType {
  case cToC
  case cToA
  case cToQ
}
/// ⚠️ Fake model used in demonstrations of UI components. Do not use in the release version.
enum DemoLevel {
  case easy
  case normal
  case hard
}
/// ⚠️ Fake model used in demonstrations of UI components. Do not use in the release version.
struct DemoUser: Hashable {
  let id: Int
  let nickName: String
}

/// ⚠️ Fake model used in demonstrations of UI components. Do not use in the release version.
struct DemoCommand:Hashable {
  var detail: String
  var level: DemoLevel
  var commandType: DemoCommandType
}
/// ⚠️ Fake model used in demonstrations of UI components. Do not use in the release version.
struct DemoSelection:Hashable {
  var title: String
  var detail: String
  var isSelected: Bool
}

/// ⚠️ SampleData for used in demonstrations of UI components. Do not use in the release version.
struct DemoSampleData {
  static var users = [
    DemoUser(id: 1, nickName: "Yanmer"),
    DemoUser(id: 2, nickName: "🍖"),
    DemoUser(id: 3, nickName: "")
  ]

  static var commands = [
    DemoCommand(detail: "Sing a song in front of others", level: .hard, commandType: .cToA),
    DemoCommand(detail: "Buy something worth maximum 5$ to Queen", level: .normal, commandType: .cToQ),
    DemoCommand(detail: "Look each other deeply 30secs", level: .easy, commandType: .cToA)
  ]
  
  static var options = [
    DemoSelection(title: "Quick select", detail: "The queen is selected as you as you tap next", isSelected: true),
    DemoSelection(title: "Card select", detail: "Those who select Queen will be the Queen!", isSelected: false)
  ]
}

