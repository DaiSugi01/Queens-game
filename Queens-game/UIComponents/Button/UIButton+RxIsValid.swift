//
//  UIButton+RxIsValid.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-26.
//

import RxSwift

extension Reactive where Base : UIButton {
  public var isValid : Binder<Bool> {
    return Binder(self.base) { button, valid in
      button.isEnabled = valid
      button.alpha = valid ? 1 : 0.3
    }
  }
}
