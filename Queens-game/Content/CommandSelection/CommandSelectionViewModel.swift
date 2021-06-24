//
//  CommandSelectionViewModel.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-06-23.
//

import Foundation
import RealmSwift

class CommandSelectionViewModel {
  func rundomCommandSelector() -> Command {
    let realm = try! Realm()
    let items = realm.objects(Command.self)
    return items.randomElement() ?? items[0]
  }
}
