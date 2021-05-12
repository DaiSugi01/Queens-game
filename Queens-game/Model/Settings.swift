//
//  Settings.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-05.
//

import Foundation

protocol SettingsProtocol {

}

extension SettingsProtocol {

  var canSkipQueenSelection: Bool { return true }
  var canSkipOrderSelection: Bool { return false }
  var queenSelectionWaitingSeconds: Int { return 5 }
  var citizenSelectionWaitingSeconds: Int { return 5 }
  var textSkipQueenSelection: String {
    return "Always skip manual Queen selection"
  }
  var textSkipOrderSelection: String {
    return "Always skip manual Order selection"
  }
  var textQueenWaitingSeconds: String {
    return "Always skip manual Order selection"
  }
  var textCitizenWaitingSeconds: String {
    return "Citizens’ selction countdown"
  }

  func skipSettings() -> [(description: String, canSkip: Bool)] {
    let firstRow = (self.textSkipQueenSelection, self.canSkipQueenSelection)
    let secondRow = (self.textSkipOrderSelection, self.canSkipOrderSelection)
    return [firstRow, secondRow]
  }
}

class Settings: SettingsProtocol {
  private init() {}
  static let shared = Settings()
  
  enum Section: String, CaseIterable {
    case toggle
    case options
  }
}
