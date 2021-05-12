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
    imv.tintColor = CustomColor.subMain
    imv.image = img
    imv.configSize(width: 22, height: 22)
    return imv
  }()
  let titleLabel = H3Label(text: "title")
  lazy var titleSet = HorizontalStackView(arrangedSubviews: [checkIcon, titleLabel], spacing: 16)
//  let bodyLabel = PLabel(text: "this is content, adlkfjal;sjdf;laj;f")
  let bodyLabel: PLabel = {
    let lb = PLabel(text: "this is content, adlkfjal;sjdf;laj;f")
    lb.numberOfLines = 3
    return lb
  }()

  lazy var stackView: UIStackView = {
    let sv = VerticalStackView(arrangedSubviews: [titleSet, bodyLabel], alignment: .leading)
    sv.configLayout(height: 160, radius: 16, shadow: true)
    // Config margin
    sv.isLayoutMarginsRelativeArrangement = true
    sv.directionalLayoutMargins = .init(top: 16, leading: 16, bottom: 16, trailing: 16)
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
          stackView.configBgColor(bgColor: CustomColor.convex)
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
          stackView.configBgColor(bgColor: .clear)
        }
        UIView.transition(with: checkIcon, duration: duration, options: .transitionCrossDissolve) {
          [unowned self] in
          checkIcon.image = UIImage(systemName: "circle")
        }
      }
    }
  }
}
