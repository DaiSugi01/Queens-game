//
//  EntryNameStackView.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/05/18.
//

import UIKit

class EntryNameStackView: UIStackView {

  let maxLength = 10
  
  let textField: UITextField = {
    let tf = UITextField()
    tf.configureLayout(
      height: 56,
      bgColor: CustomColor.backgroundLower,
      radius: 22
    )
    tf.textAlignment = .center
    tf.font = CustomFont.p
    tf.textColor = CustomColor.subText
    tf.tintColor = CustomColor.accent
    return tf
  }()

  private var userIcon = IconFactory.createImageView(type: .userId(0), width: 64)
  
  lazy var stackView: HorizontalStackView = {
    let sv = HorizontalStackView(
      arrangedSubviews: [userIcon, textField],
      spacing: 24,
      alignment: .center,
      distribution: .fill
    )
    sv.configureRadius(radius: 32)
    return sv
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    stackView.configureSuperView(under: self)
    stackView.matchParent()
    textField.delegate = self
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  /// /// Update label in user id icon
  /// - Parameters:
  ///   - id: user id which is displayed in userId icon
  ///   - text: default text which is displayed in text filed
  func configContent(by id: Int, and text: String) {
    guard let labelInIcon = (userIcon.subviews.first! as? UILabel) else { return }
    labelInIcon.text = String(id)
    textField.text = text
  }
}

extension EntryNameStackView: UITextFieldDelegate {
  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {
    let text = textField.text! + string
    if text.count <= maxLength {
        return true
    }
    
    return false
  }
}
