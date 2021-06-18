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
      switch UIScreen.main.bounds.height {
        case 0..<700:
          return 72
        case 700..<800:
          return 96
        default:
          return 128
      }
    }

    static var bottomSpacing: CGFloat {
      switch UIScreen.main.bounds.height {
        case 0..<700:
          return 72
        case 700..<800:
          return 80
        default:
          return 112
      }
    }
    
    static let leadingSpacing: CGFloat = 32
    
    static let trailingSpacing: CGFloat = 32
    
    static var topLineHeight: CGFloat {
      return topSpacing * 0.64
    }
    static var bottomLineHeight: CGFloat {
      return bottomSpacing * 0.64
    }
    
    /// Remaining space which is"`topSpacing - topLineHeight`". This is used for margin which top anchor is same as topLine.
    static var topSpacingFromTopLine: CGFloat {
      return topSpacing - topLineHeight
    }
    
    /// Remaining space which is"`bottomSpacing - bottomLineHeight`". This is used for margin which bottom anchor is same as bottomLine.
    static var bottomSpacingFromBottomLine: CGFloat {
      return bottomSpacing - bottomLineHeight
    }
  }
  
  struct UserDefaults {
    static let users: String = "Users"
  }
  
  struct QueenSelection {
    static let title = "Now, who will be the Queen?"
    
    static let options = [
      Selection(title: "Quick select", detail: "The queen is selected as you as you tap next", isSelected: true),
      Selection(title: "Card select", detail: "Those who select Queen will be the Queen!", isSelected: false)
    ]
    
    static let quickIndexPath: [IndexPath] = [[0, 0]]
    static let cardIndexPath: [IndexPath] = [[0, 1]]
  }
  
  struct PlayerSelection {
    static let minPlayerCount = 3

    static let maxPlayerCount = 9
  }
  
  struct CommandSelection {
    static let title = "How do you give the command?"
    static let options = [
      Selection(title: "Manual select", detail: "You can choose the specific order from the order list. ", isSelected: false),
      
      Selection(title: "Random select", detail: "The order will be randomly selected from the order list. You can see the list from the options.", isSelected: true)
    ]

    static let manualIndexPath: [IndexPath] = [[0, 0]]
    static let randomIndexPath: [IndexPath] = [[0, 1]]
    
  }
  
  struct CommandDescription {
    static let easy = "Not so hard to do. But are you really satisfy with it?"
    static let normal = "A bit challenging. But it shall give you a decent thrill...."
    static let hard = "Warning. This will cause a hight chaos but excitement!"
    static let cToC = "One of the citizens must perform a command to another citizen (not the Queen)."
    static let cToA = "One of the citizens must perform a command to all citizen (including the Queen)."
    static let cToQ = "One of the citizens must perform a command to the Queen"
  }
}
