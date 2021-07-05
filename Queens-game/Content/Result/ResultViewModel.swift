//
//  ResultViewModel.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-07-04.
//

import UIKit
import RxSwift

class ResultViewModel {
  
  let disposedBag = DisposeBag()
  
  func getGameManager() -> GameManagerProtocol {
    if GameManager.shared.users.count > 0 {
      return GameManager.shared
    } else {
      return MockGameManager()
    }
  }

  func getIconType() -> IconType {
    switch self.getGameManager().command.difficulty {
    case .easy:
      return .levelOne
    case .normal:
      return .levelTwo
    case .hard:
      return .levelThree
    }
  }
  
  func iconLabelCreator(_ iconType: IconType, _ label: String) -> UIStackView {
    let icon = IconFactory.createImageView(type: iconType, height: 64)
    let lb = PLabel(text: label)
    lb.textAlignment = .center
    let sv = VerticalStackView(
      arrangedSubviews: [icon, lb],
      spacing: 8
    )
    return sv
  }
  
}
