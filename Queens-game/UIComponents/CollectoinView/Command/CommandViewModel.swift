//
//  CommandSettingViewModel.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-12.
//

import UIKit
import Combine

//protocol Diffable {
//  var dataSource: UICollectionViewDiffableDataSource<Section, Item> { get }
//}
//
//class DiffableCollectionView: UICollectionView {
//  var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
//}

class CommandViewModel {
  enum CRUDType{
    case create
    case update
    case delete
  }
  
  @Published var crudType: CRUDType = .create
  var cancellables = Set<AnyCancellable>()

  var snapshot =  NSDiffableDataSourceSnapshot<Section, Item>()
  
  var commandList: [Command] = CommandViewModel.sampleCommands
  var targetCommand: Command?
  
  init() {
    updateSnapshot()
  }

  func createItem(command: Command) {
    targetCommand = command
    crudType = .create
  }
  func updateItem(command: Command) {
    targetCommand = command
    crudType = .update
  }
  func deleteItem(command: Command) {
    targetCommand = command
    crudType = .delete
  }
  func deleteItem(index: Int) {
    deleteItem(command: commandList[index])
  }
  func updateItems(searchText: String) {
    
  }
  
  func updateSnapshot() {
    snapshot.deleteAllItems()
    snapshot.appendSections([.command])
    snapshot.appendItems(Item.wrap(items: commandList), toSection: .command)
  }
  
}


extension CommandViewModel {
  static var sampleCommands = [
    Command(
      detail: "Sing a song in front of others",
      difficulty: .hard,
      commandType: .cToA
    ),
    Command(
      detail: "Buy something worth maximum 5$ to Queen",
      difficulty: .normal,
      commandType: .cToQ
    ),
    Command(
      detail: "Look each other deeply 30secs",
      difficulty: .easy,
      commandType: .cToA
    ),
    Command(
      detail: "Sing a song in front of others",
      difficulty: .hard,
      commandType: .cToA
    ),
    Command(
      detail: "Buy something worth maximum 5$ to Queen",
      difficulty: .normal,
      commandType: .cToQ
    ),
    Command(
      detail: "Look each other deeply 30secs",
      difficulty: .easy,
      commandType: .cToA
    ),
    Command(
      detail: "Sing a song in front of others",
      difficulty: .hard,
      commandType: .cToA
    ),
    Command(
      detail: "Buy something worth maximum 5$ to Queen",
      difficulty: .normal,
      commandType: .cToQ
    ),
    Command(
      detail: "Look each other deeply 30secs",
      difficulty: .easy,
      commandType: .cToA
    ),
    Command(
      detail: "Sing a song in front of others",
      difficulty: .hard,
      commandType: .cToA
    ),
    Command(
      detail: "Buy something worth maximum 5$ to Queen",
      difficulty: .normal,
      commandType: .cToQ
    ),
    Command(
      detail: "Look each other deeply 30secs",
      difficulty: .easy,
      commandType: .cToA
    )
  ]
}
