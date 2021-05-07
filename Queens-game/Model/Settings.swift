//
//  Settings.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-05.
//

import Foundation

class Settings {
  private init() {}
  static let shared = Settings()
  
  var isSkipSelection: Bool = false
  var waitingTime: Int = 5
}
