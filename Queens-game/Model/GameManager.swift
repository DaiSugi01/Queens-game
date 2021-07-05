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
    navVC?.popToRootViewController(animated: false)
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
      navVC?.popToViewController(vc, animated: false)
    } else {
      print("error: couldn't find target vc. Go back to home instead")
      goHome(navVC)
    }
  }
}


// MARK: - Mock data

struct MockGameManager: GameManagerProtocol {

  var users: [User] = {
    let user1 = User(id: UUID(), playerId: 1, name: "Paul")
    let user2 = User(id: UUID(), playerId: 2, name: "Freeman")
    let user3 = User(id: UUID(), playerId: 3, name: "Drake")
    let user4 = User(id: UUID(), playerId: 4, name: "Baldwin")
    let user5 = User(id: UUID(), playerId: 5, name: "Palmer")
    let user6 = User(id: UUID(), playerId: 6, name: "Lee")
    let user7 = User(id: UUID(), playerId: 7, name: "Fletcher")
    return [user1,user2,user3,user4,user5,user6,user7]
  }()

  var queen: User?

  var command = Command(
    detail: """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
    """,
    difficulty: .easy,
    commandType: .cToC
  )

  init() {
    self.queen = self.users[0]
  }


}
