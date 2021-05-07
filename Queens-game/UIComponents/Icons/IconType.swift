//
//  IconType.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-21.
//

import Foundation


/// Icon Type used to create icon image or image view.
enum IconType {
  // Single icons
  case citizen
  case allCitizen
  case queen
  case levelOne
  case arrow
  // Combination of single icons
  case cToC
  case cToA
  case cToQ
  case levelTwo
  case levelThree
  // Special icon
  /// Int will be displayed s userId. Eg, userId(3) -> 3️⃣
  case userId(Int)
}

///  This must not be used outside of Icon factory. This is used internally in the icon factory as a source of combination.
enum SingleIconType {
  case citizen
  case allCitizen
  case queen
  case levelOne
  case arrow
}
