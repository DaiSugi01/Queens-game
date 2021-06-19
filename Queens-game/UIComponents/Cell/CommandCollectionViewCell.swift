//
//  CommandCollectionViewCell.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-26.
//

import UIKit

/// Custom cell which is used for showing command.
/// Three contents are included in this cell
/// - Difficulty : UIImageView
/// - Command type : UIImageView
/// - Details : UI label
class CommandCollectionViewCell: UICollectionViewCell {
  
  static let identifier = "command cell"
  
  // Components of cell
  var levelIcon: UIImageView = IconFactory.createImageView(type: .levelOne, height: 16)
  var commandTypeIcon: UIImageView = IconFactory.createImageView(type: .cToC, height: 16)
  let contentLabel: PLabel = {
    let lb = PLabel()
    lb.numberOfLines = 3
    return lb
  }()
  
  // Set of difficulty and command type
  private lazy var iconSet: UIStackView = {
    let sv = VerticalStackView(
      arrangedSubviews: [levelIcon, commandTypeIcon],
      spacing: 8,
      alignment: .center,
      distribution: .fill
    )
    sv.configSize(width: 16*3)
    return sv
  }()
  
  // All set of views
  private lazy var stackView: UIStackView = {
    let sv = HorizontalStackView(
      arrangedSubviews: [contentLabel, iconSet],
      spacing: 16,
      alignment: .center,
      distribution: .fill
    )
    sv.configLayout(bgColor: CustomColor.convex, radius: 12, shadow: true)
    
    // Config margin
    sv.isLayoutMarginsRelativeArrangement = true
    sv.directionalLayoutMargins = .init(top: 16, leading: 16, bottom: 16, trailing: 16)
    return sv
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    stackView.configSuperView(under: contentView)
    stackView.matchParent()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  /// Update command text, level, type based on source
  /// - Parameter command: Command source
  func configContent(by command: Command) {
    
    // update detail text
    contentLabel.text = command.detail
    
    // update level icon
    levelIcon.removeFromSuperview() // to update view, we have to remove and add again.
    switch command.difficulty {
      case .easy:
        levelIcon = IconFactory.createImageView(type: .levelOne, height: 16)
      case .normal:
        levelIcon = IconFactory.createImageView(type: .levelTwo, height: 16)
      case .hard:
        levelIcon = IconFactory.createImageView(type: .levelThree, height: 16)
    }
    iconSet.addArrangedSubview(levelIcon)
    
    // update command icon
    commandTypeIcon.removeFromSuperview()
    switch command.commandType {
      case .cToA:
        commandTypeIcon = IconFactory.createImageView(type: .cToA, height: 16)
      case .cToC:
        commandTypeIcon = IconFactory.createImageView(type: .cToC, height: 16)
      case .cToQ:
        commandTypeIcon = IconFactory.createImageView(type: .cToQ, height: 16)
    }
    iconSet.addArrangedSubview(commandTypeIcon)
  }
  
}
