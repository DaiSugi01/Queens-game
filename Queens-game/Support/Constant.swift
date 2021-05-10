//
//  Constants.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/05/10.
//

import Foundation

struct Constant {
  struct QueenSelection {
    static let options = [
      Selection(title: "Quick select", detail: "The queen is selected as you as you tap next", isSelected: true),
      Selection(title: "Card select", detail: "Those who select Queen will be the Queen!", isSelected: false)
    ]
  }
}
