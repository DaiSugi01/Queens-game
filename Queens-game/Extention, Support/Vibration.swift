//
//  Vibration.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-07-14.
//

import UIKit

struct Vibration {
  
  static func confirm() {
    UIImpactFeedbackGenerator(style: .light).impactOccurred()
  }
  
  static func select() {
    if #available(iOS 13.0, *) {
      UISelectionFeedbackGenerator().selectionChanged()
    }
  }
  
  static func warning() {
    UINotificationFeedbackGenerator().notificationOccurred(.warning)
  }
  
  static func impact() {
    UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
  }
  
}

