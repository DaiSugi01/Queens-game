//
//  CommandSettingViewModel.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-12.
//

import UIKit
import Combine

class CommandSettingViewModel {
  enum CRUDType{
    case create
    case update
    case delete
  }
  
  @Published private var crudType: CRUDType = .create
  private var cancellables = Set<AnyCancellable>()
  
  typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
  var snapshot =  NSDiffableDataSourceSnapshot<Section, Item>()
  weak var dataSource: DataSource?
  
  var commandList: [Command] = CommandSettingViewModel.sampleCommands
  private var targetCommand: Command?
  
  init() {
    updateSnapshot()
    configObserver()
  }
  
  private func configObserver() {
    $crudType.receive(on: DispatchQueue.main)
      .sink { [unowned self] crudType in
        guard let targetCommand = self.targetCommand else { return }
        
        switch crudType {
          case .create:
            self.commandList.append(targetCommand)
          case .delete:
            self.commandList.removeAll { $0.id == targetCommand.id }
          case .update:
            if let index = self.commandList.firstIndex(where: { $0.id == targetCommand.id }) {
              self.commandList[index] = targetCommand
            }
        }
        self.updateSnapshot()
        self.applySnapshot()
      }
      // Keep cancelables
      .store(in: &cancellables)
    
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
  
  func updateSnapshot() {
    snapshot.deleteAllItems()
    snapshot.appendSections([.command])
    snapshot.appendItems(Item.wrap(items: commandList), toSection: .command)
  }
  func applySnapshot() {
    dataSource?.apply(snapshot, animatingDifferences: false, completion: nil)
  }
}

extension CommandSettingViewModel {
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
