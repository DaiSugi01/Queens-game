//
//  CommandAttributeStackView.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-06-17.
//

import UIKit

class CommandAttributeStackView: UIStackView {
  
  enum Attribute: String {
    case difficulty = "Difficulty"
    case targetType = "Type"
  }
  let command: Command!
  
  var titleLabel : H4Label!
  
  var attributeIcon: UIImageView!
  
  var attributeDescription : PLabel!
  
  init(
    command: Command,
    attributeType: Attribute,
    color: UIColor = CustomColor.text
  ) {
    
    // Title
    self.command = command
    self.titleLabel = H4Label(text: attributeType.rawValue)
    self.titleLabel.textColor = color
    
    // Icon
    let iconType = (attributeType == .difficulty)
      ? command.difficultyIconType : command.commandIconType
    self.attributeIcon = IconFactory.createImageView(type: iconType, width: 40)
    
    // Description
    let text = (attributeType == .difficulty)
      ? command.difficultyDescription : command.commandTypeDescription
    self.attributeDescription = PLabel(text: text)
    self.attributeDescription.textColor = color
    
    super.init(frame: .zero)
    
    [self.titleLabel, self.attributeIcon, self.attributeDescription]
      .forEach { addArrangedSubview($0!) }
    spacing = 8
    axis = .vertical
    alignment = .leading
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  



}
