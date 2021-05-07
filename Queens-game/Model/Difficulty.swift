//
//  Difficulty.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-05.
//

import Foundation

enum Difficulty: Int {
  case easy = 0
  case normal = 1
  case hard = 2
}

// This is for easily access the number of cases
extension Difficulty: CaseIterable {
  /// Return the num of cases in this enum
  static var count: Int {
    Difficulty.allCases.count
  }
}
