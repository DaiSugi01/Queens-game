//
//  CommandSettingViewModel.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-12.
//

import UIKit
import RxSwift
import RxRelay
import RealmSwift

class CommandViewModel {
  /// This is to annotate what operation you are doing to the observer
  enum CRUDType{
    case create
    case update
    case delete
    case other
  }
  typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
  
  // These are decided from view (view controller)
  /// CRUD operating you are doing now. With using this, view will know what to do after certain operation.
  var crudType: CRUDType = .other
  /// An item you are currently editing or looking. If this is nil, you are adding a new item.
  var selectedCommand: Command?
  var searchText: String = ""

  // RxSwift
  let disposeBag = DisposeBag()
  
  // command selecting VC
  var snapshot =  Snapshot()
  var snapshotSubject = PublishSubject<Snapshot>()
  var didReachMinItem: Bool {
    realm.objects(Command.self).count <= Constant.Command.minItems
  }
  var didReachMaxItem: Bool {
    realm.objects(Command.self).count >= Constant.Command.maxItems
  }
  lazy var didReachMinItemRelay = BehaviorRelay<Bool>(value: didReachMinItem)
  lazy var didReachMaxItemRelay = BehaviorRelay<Bool>(value: didReachMaxItem)
  
  // command confirmation VC
  /// confirmed tap ?
  let confirmedTriggerSubject = PublishSubject<Void>()
  /// dismissed ?
  let dismissSubject = PublishSubject<Void>()
  
  // Realm
  let realm = try! Realm()
  
  init() {
    readItems()
  }
  
}


extension CommandViewModel {
  
  /// Replace all items in snapshot with new items.
  func updateSnapshot(newItems: [Command]) {
    snapshot.deleteAllItems()
    snapshot.appendSections([.command])
    snapshot.appendItems(Item.wrap(items: newItems), toSection: .command)
    snapshotSubject.onNext(snapshot)
  }

  /// Read items from realm and update snapshot (and update UI)
  func readItems() {
    let items: [Command]
    let sortDescriptors: [SortDescriptor] = [
      SortDescriptor(keyPath: "intDifficulty", ascending: true),
      SortDescriptor(keyPath: "intType", ascending: true),
      SortDescriptor(keyPath: "detail", ascending: true),
    ]
    
    if searchText == "" {
      items = Array(
        realm.objects(Command.self).sorted(by: sortDescriptors)
      )
      
    } else {
      items = Array(
        realm.objects(Command.self)
          .filter("detail CONTAINS[c] %@", searchText)
          .sorted(by: sortDescriptors)
      )
    }
    
    updateSnapshot(newItems: items)
  }
  
  /// Create items in realm, and read items again
  private func createItems(commandList: [Command]) {
    try! realm.write {
      realm.add(commandList)
      sendItemCount()
    }
    
    crudType = .create
    readItems()
  }
  
  /// Update an item in realm, and read items again
  private func updateItem(_ id: String, _ detail: String, _ difficulty: Difficulty, _ commandType: CommandType) {
    if let command = realm.objects(Command.self).filter("id == %@", id).first {
      try! realm.write {
        command.detail = detail
        command.difficulty = difficulty
        command.commandType = commandType
      }
      
      crudType = .update
      readItems()
    }
  }
  
  /// Delete item from both snapshot and realm. (Don't read items again
  /// !: We first delete items from snapshot. This is because command object is reference type.
  private func deleteItem(command: Command) {
    if let command = realm.objects(Command.self).filter("id == %@", command.id).first {
      crudType = .delete
      
      snapshot.deleteItems([Item.command(command)])
      snapshotSubject.onNext(snapshot)

      try! realm.write {
        realm.delete(command)
        sendItemCount()
      }
      
    }
  }
  

  /// Create or update an item in realm with parameters passed by the view. Then read items again.
  func createOrUpdateItem(_ detail: String, _ difficulty: Difficulty, _ commandType: CommandType) {
    // edit
    if let selectedCommand = selectedCommand {
      updateItem(selectedCommand.id, detail, difficulty, commandType)
      
    // add
    } else {
      let command = Command(
        detail: detail,
        difficulty: difficulty,
        commandType: commandType
      )
      createItems(commandList: [command])
    }
  }
  
  /// Delete selected item (in edit mode). If add mode, do nothing.
  func deleteSelectedItem() {
    if let command = selectedCommand {
      deleteItem(command: command)
    }
  }
  
  /// Update a mode that you are currently adding, editing or just looking an item.
  /// - Parameter index: Int.  Relative position of item you are editing or looking in the collection view. If you pass nothing , it will be adding mode. This index is nothing to do with item's id itself.
  func updateEditMode(index: Int? = nil) {
    if let index = index  {
      selectedCommand = snapshot.itemIdentifiers(inSection: .command)[index].command
    } else {
      selectedCommand = nil
    }
  }
  
  
  /// Send the number of items in realm. This will be used if you display add or delete buttons.
  /// Ex, if items <= 3 -> disable delete button
  /// Ex, if items >= 256 -> disable add button
  func sendItemCount() {
//    itemCountSubject.onNext(realm.objects(Command.self).count)
    didReachMinItemRelay.accept(didReachMinItem)
    didReachMaxItemRelay.accept(didReachMaxItem)
  }
  
}


//extension CommandViewModel {
//  static var samples = [
//    Command(
//      detail: "Sing a song in front of others",
//      difficulty: .hard,
//      commandType: .cToA
//    ),
//    Command(
//      detail: "Buy something worth maximum 5$ to Queen",
//      difficulty: .normal,
//      commandType: .cToQ
//    ),
//    Command(
//      detail: "Look each other deeply 30secs",
//      difficulty: .easy,
//      commandType: .cToA
//    )
//  ]
//}
