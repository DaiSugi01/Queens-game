//
//  CustomSegmentedView.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-29.
//

import UIKit


/// Custom stack view which contains 1. Title, 2. info icon, and 3. segmented control
class CustomSegmentedView: UIStackView {
  
  let titleLabel: UILabel = {
    let lb = PLabel()
    return lb
  }()
  /// This icon is displayed next to title as ℹ️
  let infoIcon: UIView = {
    let uv = UIView()
    let image = UIImage(systemName: "info.circle")?.withRenderingMode(.alwaysTemplate)
    let imgv = UIImageView(image: image)
    imgv.tintColor = CustomColor.subMain
    imgv.configSize(width: 16, height: 16)
    imgv.translatesAutoresizingMaskIntoConstraints = false
    imgv.configSuperView(under: uv)
    imgv.centerYAnchor.constraint(equalTo: uv.centerYAnchor, constant: 0).isActive = true
    return uv
  }()
  lazy var titleStackView = HorizontalStackView(
    arrangedSubviews: [titleLabel, infoIcon],
    spacing: 16
  )
  
  let segmentedControl: UISegmentedControl = {
    let sc = UISegmentedControl()
    sc.backgroundColor = CustomColor.concave
    sc.selectedSegmentTintColor = CustomColor.convex
    return sc
  }()
  
  
  /// Custom initializer to create this view.
  /// - Parameters:
  ///   - title: The text of title label displayed top left.
  ///   - iconSet: These icons are used for each segments. Eg, if you pass [.citizen, .queen, .levelTree], the segmented control will be like [ 👤 | 👑 | ☠️☠️☠️ ]
  internal init(_ title: String, _ iconSet: [IconType]) {
    super.init(frame: .zero)
    self.addArrangedSubview(titleStackView)
    self.addArrangedSubview(segmentedControl)
    self.axis = .vertical
    self.spacing = 8
    self.alignment = .fill
    
    // Set title text
    titleLabel.text = title
    // Set segments
    for (i, icon) in iconSet.enumerated() {
      segmentedControl.insertSegment(
        with: IconFactory.createImage(type: icon, height: 18),
        at: i,
        animated: false
      )
    }
    
    segmentedControl.selectedSegmentIndex = 1
  }
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
