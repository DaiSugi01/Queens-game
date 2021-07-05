//
// Created by Takayuki Yamaguchi on 2021-04-27.
//

import UIKit


/// Custom cell which is displayed when let user to select some options.
class SelectionCollectionViewCell: UICollectionViewCell {
  static let identifier = "option cell"

  // Create and config views
  /// Icon for check mark. This is visible when cell is selected
  let checkIcon: UIImageView = {
    let imv = UIImageView()
    let img = UIImage(systemName: "circle")?.withRenderingMode(.alwaysTemplate)
    imv.tintColor = CustomColor.subText
    imv.image = img
    imv.configureSize(width: 22, height: 22)
    return imv
  }()
  let titleLabel = H3Label(text: "title")
  lazy var titleSet = HorizontalStackView(arrangedSubviews: [checkIcon, titleLabel], spacing: 16)
  let bodyLabel: PLabel = {
    let lb = PLabel(text: "this is content")
    lb.numberOfLines = 3
    return lb
  }()

  lazy var stackView: UIStackView = {
    let sv = VerticalStackView(arrangedSubviews: [titleSet, bodyLabel], alignment: .leading)
    sv.alignment = .fill
    sv.configureLayout(height: 144, radius: 16)
    // Configure margin
    sv.isLayoutMarginsRelativeArrangement = true
    sv.directionalLayoutMargins = .init(top: 24, leading: 16, bottom: 16, trailing: 16)
    sv.layer.borderWidth = 2.4
    sv.layer.borderColor = CustomColor.backgroundLower.cgColor
    return sv
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    stackView.configureSuperView(under: self)
    stackView.matchParent()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  /// Update content text by Selection model
  /// - Parameter selection:
  func configContent(by selection: Selection) {
    titleLabel.text = selection.title
    bodyLabel.text  = selection.detail
  }
  
  
  // Configure behaviour when cell is selected
  override var isSelected: Bool {
    didSet{
      let duration = 0.32
      if isSelected{
        // Display background and check mark
        UIView.animate(withDuration: duration/2 , delay: 0, options: .curveEaseInOut)
        { [unowned self] in
          stackView.configureBgColor(bgColor: CustomColor.backgroundUpper)
          stackView.layer.borderColor = UIColor.clear.cgColor
        }
        // `UIView.transition` is required for animation of UIImage, not `UIView.animate`
        UIView.transition(with: checkIcon, duration: duration/2, options: .transitionCrossDissolve) {
          [unowned self] in
          checkIcon.image = UIImage(systemName: "checkmark.circle")
        }

      }else{
        // Hide background and check mark
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut)
        { [unowned self] in
          stackView.configureBgColor(bgColor: .clear)
          stackView.layer.borderColor = CustomColor.backgroundLower.cgColor
        }
        UIView.transition(with: checkIcon, duration: duration, options: .transitionCrossDissolve) {
          [unowned self] in
          checkIcon.image = UIImage(systemName: "circle")
        }
      }
    }
  }
}
