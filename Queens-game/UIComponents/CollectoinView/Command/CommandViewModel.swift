//
//  CommandSettingViewModel.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-12.
//

import UIKit
import RxSwift

class CommandViewModel {
  /// This is to annotate what operation you are doing to the observer
  enum CRUDType{
    case create
    case update
    case delete
    case other
  }
  
  // These are given by view (view controller)
  var crudType: CRUDType = .other
  var selectedCommand: Command?
  var searchText: String = ""
  var snapshot =  NSDiffableDataSourceSnapshot<Section, Item>()
  
  // RxSwift
  let disposeBag = DisposeBag()
  let confirmedTriggerObservable = PublishSubject<Void>()
  var commandListSubject = BehaviorSubject<[Command]>(value: CommandViewModel.samples)
  var commandList: [Command] = CommandViewModel.samples
  var filteredCommandListSubject = BehaviorSubject<[Command]>(value: [])
  var filteredCommandList: [Command] = []

  init() {
    filteredCommandList = commandList
    updateSnapshot()
  }
  
  /// Update current editing item (command).
  /// If you are just adding new item, editing command will be nil
  func updateSelectedCommand(index: Int? = nil) {
    if let index = index  {
      selectedCommand = snapshot.itemIdentifiers(inSection: .command)[index].command
    } else {
      selectedCommand = nil
    }
  }
  
  func createItem(command: Command) {
    crudType = .create
    commandList.append(command)
    commandListSubject.onNext(commandList)
  }
  func updateItem(command: Command) {
    crudType = .update
    if let index = commandList.firstIndex(where: { $0.id == command.id }) {
      commandList[index] = command
      commandListSubject.onNext(commandList)
    }
  }
  func createOrUpdateItem(_ detail: String, _ difficulty: Difficulty, _ commandType: CommandType) {
    // edit
    if let command = selectedCommand {
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
    commandListSubject.onNext(commandList)
  }
  func deleteEditingItem() {
    if let command = selectedCommand {
      deleteItem(command: command)
    }
  }

  func filterItems() {
    if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
      restoreItems()
      return
    }
    filteredCommandList = commandList.filter { command in
      command.detail.localizedCaseInsensitiveContains(searchText.localizedLowercase)
    }
    filteredCommandListSubject.onNext(filteredCommandList)
  }
  private func restoreItems() {
    filteredCommandList.removeAll()
    filteredCommandList = commandList
    filteredCommandListSubject.onNext(filteredCommandList)
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
  static var samples = [
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
