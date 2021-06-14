//
//  BackNextButtonsView.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-17.
//

import UIKit


/// Group of next and back buttons.
/// - back (SubButton) is left side.
/// - next (MainButton) is right side.
class NextAndBackButtons: HorizontalStackView {

  let nextButton = MainButton()
  let backButton  = SubButton()
  
  /// Custom initializer to create the view
  /// - Parameters:
  ///   - superView: The view you want to set as super view. nil will be ignored.
  init(superView: UIView? = nil) {
    super.init(
      arrangedSubviews: [backButton, nextButton],
      spacing: 32,
      distribution: .fillEqually
    )
    self.configLayout(superView: superView)
    backButton.configBgColor(bgColor: CustomColor.background)
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
