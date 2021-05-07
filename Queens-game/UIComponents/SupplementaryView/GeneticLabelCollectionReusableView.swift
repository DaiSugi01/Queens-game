//
//  HeaderCollectionReusableView.swift
//  Hang-Out Planner
//
//  Created by Takayuki Yamaguchi on 2021-03-28.
//

import UIKit

/// Header view for collection view. You can set any kind of label by using this view.
class GeneticLabelCollectionReusableView: UICollectionReusableView {
  static let identifier = "generic label"
  
  var label: UILabel?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  
  /// Set label for the header.
  /// - Parameter lb: Any label which inherit UILabel is acceptable.
  func configLabel(lb: UILabel) {
    // Reset and add label
    lb.removeFromSuperview()
    lb.configSuperView(under: self)
    lb.matchParent()
  }
}
