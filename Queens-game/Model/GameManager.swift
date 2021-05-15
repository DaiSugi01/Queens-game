//
//  GameManager.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-05.
//

import Foundation
import UIKit

protocol GameManagerProtocol {

  var users: [User] { get set }
  var queen: User? { get set }
  var command: Command { get set }
}

class GameManager: GameManagerProtocol {
  private init() {}
  static let shared = GameManager()

  var users: [User] = []
  var queen: User?
  var gameProgress: [UIViewController] = []
  var command: Command = Command()

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
