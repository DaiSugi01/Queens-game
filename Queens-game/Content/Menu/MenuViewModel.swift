//
//  MenuViewModel.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-06-27.
//

import UIKit
import RxSwift

class  MenuViewModel {
  
  let disposeBag = DisposeBag()
  
  /// Determine if we need quit button (go to top button) or not.
  /// Basically, it's true but from top VC, we make it false.
  var isTopMenu: Bool = false
  
  /// Navigation controller inherited by outer instance. It is not the one this class belongs to
  weak var navigationController: UINavigationController?
}
