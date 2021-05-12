//
//  Constants.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/05/10.
//

import UIKit

struct Constant {
  
  struct Common {
    static var topSpacing: CGFloat {
      let screenHeight: CGFloat = UIScreen.main.bounds.height
      if screenHeight < 700 {
        return 64
      } else if screenHeight < 800 {
        return 96
      } else {
        return 128
      }
    }
    
    static var bottomSpacing: CGFloat {
      if UIScreen.main.bounds.height < 700 {
        return -48
      } else {
        return -96
      }
    }
    
    static let leadingSpacing: CGFloat = 32
    
    static let trailingSpacing: CGFloat = -32
  }
  
  struct QueenSelection {
    static let options = [
      Selection(title: "Quick select", detail: "The queen is selected as you as you tap next", isSelected: true),
      Selection(title: "Card select", detail: "Those who select Queen will be the Queen!", isSelected: false)
    ]
    
    static let quickIndexPath: [IndexPath] = [[0, 0]]
    static let cardIndexPath: [IndexPath] = [[0, 1]]
    static let cardBottomSpacing: CGFloat = 112
  }
}
