//
//  MultiIconFactory.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-20.
//

import UIKit


/// This class generates image or image view based on `IconType` you refer.
///
/// # Usage example
/// ```
/// IconFactory.createImage(type: .citizen, height: 16)
/// IconFactory.createImageView(type: .levelThree, width: 48)
/// ```
class IconFactory { }


// MARK: - Create ImageView

extension IconFactory {
  
  /// Create a ui image view from `IconType`
  /// - Parameters:
  ///   - type: `IconType` that you want to create
  ///   - width: Width of icon. Either width or height must be nil to protect aspect ratio.
  ///   - height: Height of icon. Either width or height must be nil to protect aspect ratio.
  /// - Returns: UIImageView which includes icon image created by `IconFactory.createImage()`
  private static func createImageView(
    type: IconType,
    width: CGFloat?,
    height: CGFloat?
  ) -> UIImageView {

    // If only type is `userID`, we use specific icon class and return.
    if case let .userId(id) = type {
      return UserIdIconView(id: id, size: width != nil ? width : height)
    }
    // Create image and set to image view
    let image = IconFactory.createImage(type: type, width: width, height: height)
    return UIImageView(image: image)
  }
}

// MARK: - Public functions of `Create ImageView`

extension IconFactory {
  
  /// Create a ui image from `IconType`
  /// - Parameters:
  ///   - type: `IconType` that you want to create
  ///   - width: Width of icon. Once you set width, you must not modify height to preserve aspect ratio.
  /// - Returns:  UIImageView which includes icon image created by `IconFactory.createImage()`
  static func createImageView(
    type: IconType,
    width: CGFloat
  ) -> UIImageView {
    return createImageView(type: type , width: width, height: nil)
  }
  
  
  /// Create a ui image from `IconType`
  /// - Parameters:
  ///   - type: `IconType` that you want to create
  ///   - height: Height of icon. Once you set width, you must not modify width to preserve aspect ratio.
  /// - Returns:  UIImageView which includes icon image created by `IconFactory.createImage()`
  static func createImageView(
    type: IconType,
    height: CGFloat
  ) -> UIImageView {
    return createImageView(type: type, width: nil, height: height)
  }
}


// MARK: - Create Image

extension IconFactory {
  /// Basic size of icon size. Based on this, we calculate the scale and adjust to transform. Technically, whatever size is ok.
  static let iconBasicSize: CGFloat = 16
  
  
  /// Create an `UIImage` which possesses "single icon" from `UIBezierPath`.
  /// - Parameters:
  ///   - type: `SingleIconType` that you want to create as Image.
  ///   - size: Size of the icon you want to create.
  ///   - color: Color of icon.
  /// - Returns: UIImage created from `UIBezierPath`.
  private static func createImage(
    type: SingleIconType,
    size: CGFloat,
    color: UIColor
  ) -> UIImage {
    return UIGraphicsImageRenderer(size: CGSize(width: size, height: size)).image { _ in
      let path: UIBezierPath
      // We can't use static `UIBezierPath` (it will cause weird behaviour because of the reference ? ). We have to make instance of path.
      let iconSource = IconSource()
      
      // Create path.
      switch type {
        case .citizen:
          path = iconSource.citizen
        case .allCitizen:
          path = iconSource.allCitizens
        case .queen:
          path = iconSource.queen
        case .levelOne:
          path = iconSource.skull
        case .arrow:
          path = iconSource.arrow
      }
      
      // Set Size
      // We can't change size directly by width or height. Scale is only way to adjust the size.
      let scale = size/iconBasicSize
      let scaleTransform = CGAffineTransform(scaleX: scale, y: scale)
      path.apply(scaleTransform)

      // Set color
      color.setFill()
      path.fill()
    }
  }
  
  
  /// Create an UIImage which possesses multiple icons  from `UIBezierPath`. Internally, we call createImage(`SingleIconType`) several times and combine them.
  /// # Caution!⚠️: You can't call .userId(int). It will just return UIImage()
  /// - Parameters:
  ///   - type: `IconType` you want to create as UIImage.
  ///   - width: Width of the icon image size. Either width or height must be nil to protect aspect ratio.
  ///   - height: Height of the icon image size. Either width or height must be nil to protect aspect ratio.
  /// - Returns: Single UIImage.
  private static func createImage(
    type: IconType,
    width: CGFloat?,
    height: CGFloat?
  ) -> UIImage {
    
    /// Set of icon. Eg, [A, C, B] will create single UIImage of "ACB"
    var iconSet: [SingleIconType]
    /// Set of color. Eg, [blue, white, black] will create single UIImage of "ACB" which A: blue, C: white, B: Black.
    var colorSet: [UIColor]
    var image =  UIImage()
    
    // Set parameters.
    switch type {
      case .citizen:
        iconSet = [.citizen]
        colorSet = [CustomColor.subMain]
      case .allCitizen:
        iconSet = [.allCitizen]
        colorSet = [CustomColor.subMain]
      case .queen:
        iconSet = [.queen]
        colorSet = [CustomColor.accent]
      case .levelOne:
        iconSet = [.levelOne]
        colorSet = [CustomColor.subMain]
      case .arrow:
        iconSet = [.arrow]
        colorSet = [CustomColor.subMain]
      case .cToC:
        iconSet = [.citizen, .arrow, .citizen]
        colorSet = [CustomColor.subMain, CustomColor.subMain, CustomColor.subMain]
      case .cToA:
        iconSet = [.citizen, .arrow, .allCitizen]
        colorSet = [CustomColor.subMain, CustomColor.subMain, CustomColor.subMain]
      case .cToQ:
        iconSet = [.citizen, .arrow, .queen]
        colorSet = [CustomColor.subMain, CustomColor.subMain, CustomColor.accent]
      case .levelTwo:
        iconSet = [.levelOne, .levelOne]
        colorSet = [CustomColor.subMain, CustomColor.accent]
      case .levelThree:
        iconSet = [.levelOne, .levelOne, .levelOne]
        colorSet = [CustomColor.subMain, CustomColor.accent, CustomColor.accent]
      case .userId( _):
        return image
    }
    
    // Either width or height will be used. (to preserve ratio)
    let size = width != nil ? width : height
    // Create and combine image.
    for (type, color) in zip(iconSet, colorSet) {
      image = image.append(image: createImage(type: type, size: size!, color: color), to: .right)
    }
    // This `.alwaysOriginal` is required, otherwise it will be always blurred in segment control.
    return image.withRenderingMode(.alwaysOriginal)
  }
}

// MARK: - Public functions of `Create Image`

extension IconFactory {
  
  /// Create UIImage by `IconType`
  /// # Caution!⚠️: You can't call .userId(int). It will just return UIImage()
  /// - Parameters:
  ///   - type: The `IconType` you want to create as UIImage
  ///   - width: Width of icon. Once you set width, you must not modify height to preserve aspect ratio.
  /// - Returns: UIImage.
  static func createImage(
    type: IconType,
    width: CGFloat
  ) -> UIImage {
    return createImage(type: type, width: width, height: nil)
  }
  
  
  /// Create UIImage by `IconType`
  /// # Caution!⚠️: You can't call .userId(int). It will just return UIImage()
  /// - Parameters:
  ///   - type: The `IconType` you want to create as UIImage
  ///   - height: Height of icon. Once you set height, you must not modify width to preserve aspect ratio.
  /// - Returns: UIImage
  static func createImage(
    type: IconType,
    height: CGFloat
  ) -> UIImage {
    return createImage(type: type, width: nil, height: height)
  }
}
