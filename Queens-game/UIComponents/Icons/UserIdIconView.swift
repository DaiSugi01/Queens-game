//
//  UserIdIView.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-25.
//

import UIKit


/// Icon view class used for user Id icon.
/// This view contains `label` in addition to UIImageView.
/// This `label` will be displayed as user id.
class UserIdIconView: UIImageView {
  let label = H2Label()
  init(id: Int, size: CGFloat? = 64) {
    super.init(frame: .zero)
    label.text = String(id)
    label.textAlignment = .center
    label.configureSuperView(under: self)
    label.centerXYin(self)
    label.textColor = CustomColor.background
    
    self.configureRadius(radius: 24)
    self.configureBgColor(bgColor: CustomColor.subText)
    self.configureSize(width: size, height: size)
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
