//
//  UISearchBar+configLayout.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-28.
//

import UIKit

extension UISearchBar {
  
  /// Config additional layout of UISearchBar
  /// - Parameters:
  ///   - backgroundColor: Color of background of the search bar
  ///   - inputTextColor: Color of input text
  ///   - placeholderColor: Color of place holder text
  ///   - searchIconColor: Color of search icon on left side
  func configLayout(
    backgroundColor: UIColor = .white,
    inputTextColor: UIColor = .black,
    placeholderColor: UIColor = .gray,
    searchIconColor: UIColor = .black
  ) {
    
    self.searchBarStyle = .minimal
    self.barStyle = .default

    if let textField = self.value(forKey: "searchField") as? UITextField {
      // Set Background Color
      textField.backgroundColor = backgroundColor
      // Set text Color
      textField.textColor = inputTextColor
      // Set placeholder Color
      textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : placeholderColor])
      // Set default Search icon(image on the left edge) Color
      if let leftView = textField.leftView as? UIImageView {
        leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
        leftView.tintColor = searchIconColor
      }
      // Set cornerRadius
      textField.layer.cornerRadius = 16
      textField.clipsToBounds = true
    }
  }
}
