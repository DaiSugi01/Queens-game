//
//  CommandSettingViewModel.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-12.
//

import UIKit
import Combine

class CommandViewModel {
  /// This is to annotate what operation you are doing to the observer
  enum CRUDType{
    case create
    case update
    case delete
    case other
  }
  
  var crudType: CRUDType = .other
  var cancellables = Set<AnyCancellable>()
  @Published var commandList: [Command] = CommandViewModel.sampleCommands
  @Published var filteredCommandList: [Command] = []
  var editingCommand: Command?
  
  var snapshot =  NSDiffableDataSourceSnapshot<Section, Item>()
  
  init() {
    filteredCommandList = commandList
    updateSnapshot()
  }
  
  func updateEditingCommand(index: Int? = nil) {
    guard let index = index else {
      editingCommand = nil
      return
    }
    editingCommand = snapshot.itemIdentifiers(inSection: .command)[index].command
  }
  
  func createItem(command: Command) {
    crudType = .create
    commandList.append(command)
  }
  func updateItem(command: Command) {
    crudType = .update
    if let index = commandList.firstIndex(where: { $0.id == command.id }) {
      commandList[index] = command
    }
  }
  func createOrUpdateItem(_ detail: String, _ difficulty: Difficulty, _ commandType: CommandType) {
    // edit
    if let command = editingCommand {
      command.detail = detail
      command.difficulty = difficulty
      command.commandType = commandType
      updateItem(command: command)
    // add
    } else {
      let command = Command(detail: detail, difficulty: difficulty, commandType: commandType)
      createItem(command: command)
    }
  }
  
  func deleteItem(command: Command) {
    crudType = .delete
    commandList.removeAll { $0.id == command.id }
  }
  func deleteEditingItem() {
    if let command = editingCommand {
      deleteItem(command: command)
    }
  }

  func filterItems(_ searchText: String) {
    if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
      restoreItems()
      return
    }
    filteredCommandList = commandList.filter { command in
      command.detail.localizedCaseInsensitiveContains(searchText.localizedLowercase)
    }
  }
  func restoreItems() {
    filteredCommandList.removeAll()
    filteredCommandList = commandList
  }
  func updateSnapshot() {
    snapshot.deleteAllItems()
    snapshot.appendSections([.command])
    snapshot.appendItems(Item.wrap(items: commandList), toSection: .command)
  }
  func updateSnapshotFiltered() {
    snapshot.deleteAllItems()
    snapshot.appendSections([.command])
    snapshot.appendItems(Item.wrap(items: filteredCommandList), toSection: .command)
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
