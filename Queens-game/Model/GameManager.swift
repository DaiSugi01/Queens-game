//
//  GameManager.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-05.
//

import Foundation
import UIKit

class GameManager {
  private init() {}
  static let shared = GameManager()

  var users: [User] = []
  var queen: User?
  var gameProgress: [UIViewController] = []

  func pushGameProgress(navVC: UINavigationController,
                        currentScreen: UIViewController,
                        nextScreen: UIViewController) {
    gameProgress.append(currentScreen)
    navVC.pushViewController(nextScreen, animated: true)
  }

  func popGameProgress(navVC: UINavigationController) {
    gameProgress.removeLast()
    navVC.popViewController(animated: true)
  }
}
