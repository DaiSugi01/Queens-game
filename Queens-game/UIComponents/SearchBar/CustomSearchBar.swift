//
//  CustomSearchBar.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-28.
//

import UIKit


/// Custom search bar used in this project.
/// - It has "Search" text as placeholder
/// - Colors of background, input text, place holder, and search icon are changed for this project.
/// - Size is same as Super class.
class CustomSearchBar: UISearchBar {

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.placeholder = "Search"
    self.configLayout(backgroundColor: CustomColor.concave,
                           inputTextColor: CustomColor.subMain,
                           placeholderColor: CustomColor.subMain.withAlphaComponent(0.3),
                           searchIconColor: CustomColor.subMain
    )
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }  
  
}