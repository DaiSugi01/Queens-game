//
//  Settings.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-05.
//

import Foundation

protocol SettingsProtocol {
  
  var canSkipQueen: Bool { get set }
  var canSkipCommand: Bool { get set }
  var queenWaitingSeconds: Double { get set }
  var citizenWaitingSeconds: Double { get set }
  
  func saveByMySelf() -> Void
}

extension SettingsProtocol {
  
  var userDefaultsKey: String { "Settings" }
  
  var canSkipQueen: Bool { true }
  var canSkipCommand: Bool { false }
  var queenWaitingSeconds: Double { 5 }
  var citizenWaitingSeconds: Double { 6 }
  
  var canSkipQueenDescription: String {
    return "Skip count down when choosing the Queen."
  }
  var canSkipCommandDescription: String {
    return "Skip count down when choosing targets."
  }
  var queenWaitingSecondsDescription: String {
    return "Countdown time when choosing the Queen."
  }
  var citizenWaitingSecondsDescription: String {
    return "Countdown time when choosing targets."
  }
  static var canSkipQueenIdentifier: String { "canSkipQueen" }
  static var canSkipCommandIdentifier: String { "canSkipCommand" }
  static var queenWaitingSecondsIdentifier: String { "queenWaiting" }
  static var citizenWaitingSecondsIdentifier: String { "citizenWaiting" }
  
  
  /// Get source of setting item which is `canSkip` type.
  /// - Parameter identifier: specific identifier related to each item
  /// - Returns: description: item description,  canSkip: weather you can skip its step or not
  func getCanSkipSource(_ type: canSkip) -> (description: String, canSkip: Bool) {
    switch type {
      case .queen:
        return (canSkipQueenDescription, canSkipQueen)
      case .command:
        return (canSkipCommandDescription, canSkipCommand)
    }
  }
  
  /// Get source of setting item which is `WaitingSeconds` type.
  /// - Parameter identifier: specific identifier related to each item
  /// - Returns: description: item description,  sec: how long you have to wait til its end.
  func getWaitingSecondsSource(_ type: WaitingSeconds) -> (description: String, sec: Double) {
    switch type {
      case .queen:
        return (queenWaitingSecondsDescription, queenWaitingSeconds)
      case .citizen:
        return (citizenWaitingSecondsDescription, citizenWaitingSeconds)
    }
  }
  
  /// Update Settings Parameters.
  mutating func updateSkipQueenSelection(_ bool: Bool) {
    self.canSkipQueen = bool
  }
  
  mutating func updateSkipCommandSelection(_ bool: Bool) {
    self.canSkipCommand = bool
  }
  
  mutating func updateQueenSelectionWaitingSeconds(sec: Double) {
    self.queenWaitingSeconds = sec
  }
  
  mutating func updateCitizenSelectionWaitingSeconds(sec: Double) {
    self.citizenWaitingSeconds = sec
  }
  
}

protocol SettingType { }

enum canSkip: SettingType {
  case queen
  case command
}
enum WaitingSeconds: SettingType {
  case queen
  case citizen
}

class Settings: SettingsProtocol, Codable {
  
  static let shared = Settings()
  
  var canSkipQueen: Bool = false
  var canSkipCommand: Bool = false
  var queenWaitingSeconds: Double = 5
  var citizenWaitingSeconds: Double = 5
  
  private init() {
    let jsonDecoder = JSONDecoder()
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    if let data = UserDefaults.standard.data(forKey: self.userDefaultsKey) {
      print("init: \(data)")
      let fromUserDefaults = try! jsonDecoder.decode(Settings.self, from: data)
      self.canSkipQueen = fromUserDefaults.canSkipQueen
      self.canSkipCommand = fromUserDefaults.canSkipCommand
      self.queenWaitingSeconds = fromUserDefaults.queenWaitingSeconds
      self.citizenWaitingSeconds = fromUserDefaults.citizenWaitingSeconds
    }
  }
  
  func saveByMySelf() {
    let jsonEncoder = JSONEncoder()
    jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
    guard let data = try? jsonEncoder.encode(Settings.shared) else {
      return
    }
    UserDefaults.standard.set(data, forKey: self.userDefaultsKey)
  }
  
}
