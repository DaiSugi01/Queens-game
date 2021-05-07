//
//  CommandType.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-05.
//

import Foundation

enum CommandType: Int{
  case cToC = 0
  case cToA = 1
  case cToQ = 2
}

// This is for easily access the number of cases
extension CommandType: CaseIterable {
  /// Return the num of cases in this enum
  static var count: Int {
    CommandType.allCases.count
  }
}
