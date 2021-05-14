//
//  Settings.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-05.
//

import Foundation

protocol SettingsProtocol {
  var canSkipQueenSelection: Bool { get set }
  var canSkipOrderSelection: Bool { get set }
  var queenSelectionWaitingSeconds: Double { get set }
  var citizenSelectionWaitingSeconds: Double { get set }

  func saveByMySelf() -> Void
}

extension SettingsProtocol {

  var userDefaultsKey: String { "Settings" }

  var canSkipQueenSelection: Bool { true }
  var canSkipOrderSelection: Bool { false }
  var queenSelectionWaitingSeconds: Double { 5 }
  var citizenSelectionWaitingSeconds: Double { 6 }
  var textSkipQueenSelection: String {
    return "Always skip manual Queen selection"
  }
  var textSkipOrderSelection: String {
    return "Always skip manual Order selection"
  }
  var textQueenWaitingSeconds: String {
    return "Queen’s selection countdown"
  }
  var textCitizenWaitingSeconds: String {
    return "Citizen’s selection countdown"
  }

  func skipSettings() -> [(description: String, canSkip: Bool)] {
    let firstRow = (self.textSkipQueenSelection, self.canSkipQueenSelection)
    let secondRow = (self.textSkipOrderSelection, self.canSkipOrderSelection)
    return [firstRow, secondRow]
  }

  func waitingSeconds() -> [(description: String, sec: Double)] {
    let firstRow = (
      self.textQueenWaitingSeconds,
      self.queenSelectionWaitingSeconds
    )
    let secondRow = (
      self.textCitizenWaitingSeconds,
      self.citizenSelectionWaitingSeconds
    )
    return [firstRow,secondRow]
  }

  /// Update Settings Parameters.
  mutating func updateSkipQueenSelection(_ bool: Bool) {
    self.canSkipQueenSelection = bool
  }

  mutating func updateSkipOrderSelection(_ bool: Bool) {
    self.canSkipOrderSelection = bool
  }

  mutating func updateQueenSelectionWaitingSeconds(sec: Double) {
    self.queenSelectionWaitingSeconds = sec
  }

  mutating func updateCitizenSelectionWaitingSeconds(sec: Double) {
    self.citizenSelectionWaitingSeconds = sec
  }

}

class Settings: SettingsProtocol, Codable {

  static let shared = Settings()

  var canSkipQueenSelection: Bool = true
  var canSkipOrderSelection: Bool = false
  var queenSelectionWaitingSeconds: Double = 5
  var citizenSelectionWaitingSeconds: Double = 6

  private init() {
    let jsonDecoder = JSONDecoder()
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    if let data = UserDefaults.standard.data(forKey: self.userDefaultsKey) {
      print("init: \(data)")
      let fromUserDefaults = try! jsonDecoder.decode(Settings.self, from: data)
      self.canSkipQueenSelection = fromUserDefaults.canSkipQueenSelection
      self.canSkipOrderSelection = fromUserDefaults.canSkipOrderSelection
      self.queenSelectionWaitingSeconds = fromUserDefaults.queenSelectionWaitingSeconds
      self.citizenSelectionWaitingSeconds = fromUserDefaults.citizenSelectionWaitingSeconds
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
