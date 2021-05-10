//
//  Selection.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-05.
//

import Foundation

/// This is used when user make a choice. Eg, random select or manual select in `CommandSelectionViewController`
struct Selection: Hashable {
  var title: String
  var detail: String
  var isSelected: Bool
  
  static let options = [
    Selection(title: "Quick select", detail: "The queen is selected as you as you tap next", isSelected: true),
    Selection(title: "Card select", detail: "Those who select Queen will be the Queen!", isSelected: false)
  ]
}
