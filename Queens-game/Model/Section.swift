//
//  SectionItem.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-05.
//

import Foundation

// MARK: - Section
/// Section of enum used for diffable data source.
enum Section: Hashable {
  /// This section is used for collection view when inputting user name such as `EntryNameViewController`
  case userName
  /// This section is used for collection view when accessing command such as  `CommandSettingViewController` and `CommandManualSelectingViewController`
  case command
  /// This section is used for collection view when selecting choices such as `QueenSelectionViewController` and `CommandSelectionViewController`
  case selection
}
