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
  func getCanSkipSource(_ identifier: String) -> (description: String, canSkip: Bool) {
    switch identifier {
      case Settings.canSkipQueenIdentifier:
        return (canSkipQueenDescription, canSkipQueen)
      case Settings.canSkipCommandIdentifier:
        return (canSkipCommandDescription, canSkipCommand)
      default:
        print("no match")
        return (canSkipQueenDescription, canSkipQueen)
    }
  }
  
  /// Get source of setting item which is `WaitingSeconds` type.
  /// - Parameter identifier: specific identifier related to each item
  /// - Returns: description: item description,  sec: how long you have to wait til its end.
  func getWaitingSecondsSource(_ identifier: String) -> (description: String, sec: Double) {
    switch identifier {
      case Settings.queenWaitingSecondsIdentifier:
        return (queenWaitingSecondsDescription, queenWaitingSeconds)
      case Settings.citizenWaitingSecondsIdentifier:
        return (citizenWaitingSecondsDescription, citizenWaitingSeconds)
      default:
        print("no match")
        return (queenWaitingSecondsDescription, queenWaitingSeconds)
    }
  }
  
  /// Update Settings Parameters.
  mutating func updateSkipQueenSelection(_ bool: Bool) {
    self.canSkipQueen = bool
  }
  
  mutating func updateSkipOrderSelection(_ bool: Bool) {
    self.canSkipCommand = bool
  }
  
  mutating func updateQueenSelectionWaitingSeconds(sec: Double) {
    self.queenWaitingSeconds = sec
  }
  
  mutating func updateCitizenSelectionWaitingSeconds(sec: Double) {
    self.citizenWaitingSeconds = sec
  }
  
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
