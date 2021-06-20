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


  
  /// Record(append) current vc (progress) into game manager
  /// - Parameters:
  ///   - navVC: The navigation VC which current VC belongs to.
  ///   - currentScreen: The vc you want to record
  ///   - nextScreen: The next view to display
  func pushGameProgress(navVC: UINavigationController?,
                        currentScreen: UIViewController,
                        nextScreen: UIViewController) {
    guard let navVC = navVC else { return }
    gameProgress.append(currentScreen)
    navVC.pushViewController(nextScreen, animated: true)
  }

  
  /// Load (pop and release) previous vc from the game manager
  /// - Parameter navVC: The navigation VC which current VC belongs to.
  func popGameProgress(navVC: UINavigationController?) {
    guard let navVC = navVC else { return }
    if !gameProgress.isEmpty {
      gameProgress.removeLast()
    }
    navVC.popViewController(animated: true)
  }
  
  /// Reset all data that game manager holds
  ///  - users: remove all
  ///  - queen: nil
  ///  - gamProgress: remove all
  ///  - command: Commnad()
  func resetGameManeger() {
    users.removeAll()
    queen = nil
    gameProgress.removeAll()
    command = Command()
  }
}


// Helper function for loading gameProgress
extension GameManager {
  
  enum loadScreen {
    case home, queenSelection, commandSelection
  }
  
  
  /// Load (go back and release) to some certain vc from the game manager.
  /// # The gameProcess from last till target vc  will be all deleted!
  /// - Parameters:
  ///   - screen: target VC
  ///   - navVC: The navigation VC which current VC belongs to.
  func loadGameProgress(to screen: loadScreen, with navVC: UINavigationController?) {
    switch screen {
      
      case .home:
        goHome(navVC)
      case .queenSelection:
        queen = nil
        command = Command()
        goBackTo(navVC, classType: QueenSelectionViewController.self)
      case .commandSelection:
        command = Command()
        goBackTo(navVC, classType: CommandSelectionViewController.self)
    }
  }
  
  private func goHome(_ navVC: UINavigationController?) {
    navVC?.popToRootViewController(animated: true)
    resetGameManeger()
  }
  
  private func goBackTo<T>(_ navVC: UINavigationController?, classType: T.Type) {
    
    // if target VC is at last -> just pop
    if let vc = gameProgress.last, type(of: vc) == T.self {
      popGameProgress(navVC: navVC)
      return
    }
    
    // if [] or [not target vc] -> home
    if gameProgress.count <= 1 {
      goHome(navVC)
      return
    }

    // Go back to target vc and remove all progress until that.
    // eg. [vc, vc, vc, target vc, vc, vc] -> [vc, vc, vc]
    if let index = gameProgress.lastIndex(where: { type(of: $0) == T.self }) {
      let vc = gameProgress[index]
      gameProgress.removeSubrange( index..<gameProgress.count )
      navVC?.popToViewController(vc, animated: true)
    } else {
      print("error: couldn't find target vc. Go back to home instead")
      goHome(navVC)
    }
  }
}
