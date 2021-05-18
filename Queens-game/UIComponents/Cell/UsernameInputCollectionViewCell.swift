//
//  UsernameInputCollectionViewCell.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-26.
//

import UIKit

/// Custom cell that includes
/// - user id icon
/// - text filed to keep user name
class UsernameInputCollectionViewCell: UICollectionViewCell {
  static let identifier = "username cell"

  let textField: UITextField = {
    let tf = UITextField()
    tf.configLayout(
      height: 56,
      bgColor: CustomColor.concave,
      radius: 22
    )
    tf.textAlignment = .center
    tf.font = CustomFont.h4
    tf.textColor = CustomColor.subMain
    return tf
  }()

  private var userIcon = IconFactory.createImageView(type: .userId(0), width: 64)
  
  private lazy var stackView: UIStackView = {
    let sv = HorizontalStackView(
      arrangedSubviews: [userIcon, textField],
      spacing: 24,
      alignment: .center,
      distribution: .fill
    )
    sv.configRadius(radius: 32)
    return sv
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    stackView.configSuperView(under: self)
    stackView.matchParent()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  /// /// Update label in user id icon
  /// - Parameters:
  ///   - id: user id which is displayed in userId icon
  ///   - text: default text which is displayed in text filed
  func configContent(by id: Int, and text: String) {
    // update usr id
    guard let labelInIcon = (userIcon.subviews.first! as? UILabel) else { return }
    labelInIcon.text = String(id)
    // update text filed
    textField.text = text
  }
}
