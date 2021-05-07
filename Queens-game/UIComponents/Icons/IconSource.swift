//
//  IconSource.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-20.
//

import UIKit

/// This struct contains paths (`UIBezierPath`). They will be used to generate UIImage.
/// Intentionally not using static! Otherwise if you create multiple icon, they will all look strange
struct IconSource {

  let citizen: UIBezierPath = {
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 12.4, y: 13))
    path.addCurve(to: CGPoint(x: 9.9, y: 10.8), controlPoint1: CGPoint(x: 10.7, y: 12.7), controlPoint2: CGPoint(x: 9.1, y: 12.3))
    path.addCurve(to: CGPoint(x: 8, y: 4), controlPoint1: CGPoint(x: 12.2, y: 6.4), controlPoint2: CGPoint(x: 10.5, y: 4))
    path.addCurve(to: CGPoint(x: 6.1, y: 10.8), controlPoint1: CGPoint(x: 5.5, y: 4), controlPoint2: CGPoint(x: 3.8, y: 6.5))
    path.addCurve(to: CGPoint(x: 3.6, y: 13), controlPoint1: CGPoint(x: 6.9, y: 12.3), controlPoint2: CGPoint(x: 5.3, y: 12.7))
    path.addCurve(to: CGPoint(x: 2, y: 15.5), controlPoint1: CGPoint(x: 2.1, y: 13.4), controlPoint2: CGPoint(x: 2, y: 14.2))
    path.addLine(to: CGPoint(x: 2, y: 16))
    path.addLine(to: CGPoint(x: 14, y: 16))
    path.addLine(to: CGPoint(x: 14, y: 15.5))
    path.addCurve(to: CGPoint(x: 12.4, y: 13), controlPoint1: CGPoint(x: 14, y: 14.2), controlPoint2: CGPoint(x: 14, y: 13.4))
    path.close()

    return path
  }()
  
  let allCitizens: UIBezierPath = {
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 5.3, y: 16))
    path.addLine(to: CGPoint(x: 16, y: 16))
    path.addLine(to: CGPoint(x: 16, y: 15.4))
    path.addCurve(to: CGPoint(x: 14.6, y: 13.3), controlPoint1: CGPoint(x: 16, y: 14.3), controlPoint2: CGPoint(x: 15.9, y: 13.6))
    path.addCurve(to: CGPoint(x: 12.3, y: 11.3), controlPoint1: CGPoint(x: 13.1, y: 12.9), controlPoint2: CGPoint(x: 11.6, y: 12.6))
    path.addCurve(to: CGPoint(x: 10.7, y: 5), controlPoint1: CGPoint(x: 14.4, y: 7.2), controlPoint2: CGPoint(x: 12.9, y: 5))
    path.addCurve(to: CGPoint(x: 9, y: 11.3), controlPoint1: CGPoint(x: 8.4, y: 5), controlPoint2: CGPoint(x: 6.9, y: 7.3))
    path.addCurve(to: CGPoint(x: 6.7, y: 13.3), controlPoint1: CGPoint(x: 9.7, y: 12.6), controlPoint2: CGPoint(x: 8.2, y: 12.9))
    path.addCurve(to: CGPoint(x: 5.3, y: 15.4), controlPoint1: CGPoint(x: 5.4, y: 13.6), controlPoint2: CGPoint(x: 5.3, y: 14.3))
    path.addLine(to: CGPoint(x: 5.3, y: 16))
    path.close()
    path.move(to: CGPoint(x: 4, y: 16))
    path.addLine(to: CGPoint(x: 0, y: 16))
    path.addLine(to: CGPoint(x: 0, y: 15.6))
    path.addCurve(to: CGPoint(x: 1.1, y: 14), controlPoint1: CGPoint(x: 0, y: 14.7), controlPoint2: CGPoint(x: 0.1, y: 14.2))
    path.addCurve(to: CGPoint(x: 2.8, y: 12.5), controlPoint1: CGPoint(x: 2.2, y: 13.7), controlPoint2: CGPoint(x: 3.3, y: 13.5))
    path.addCurve(to: CGPoint(x: 4, y: 7.8), controlPoint1: CGPoint(x: 1.2, y: 9.4), controlPoint2: CGPoint(x: 2.3, y: 7.8))
    path.addCurve(to: CGPoint(x: 6, y: 9.9), controlPoint1: CGPoint(x: 5.1, y: 7.8), controlPoint2: CGPoint(x: 6, y: 8.5))
    path.addCurve(to: CGPoint(x: 4, y: 16), controlPoint1: CGPoint(x: 6, y: 13.5), controlPoint2: CGPoint(x: 4, y: 11.5))
    path.close()

    return path
  }()
  
  let queen: UIBezierPath = {
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 3.9, y: 14.2))
    path.addLine(to: CGPoint(x: 12.1, y: 14.2))
    path.addLine(to: CGPoint(x: 12.1, y: 16))
    path.addLine(to: CGPoint(x: 3.9, y: 16))
    path.addLine(to: CGPoint(x: 3.9, y: 14.2))
    path.close()
    path.move(to: CGPoint(x: 13.8, y: 7))
    path.addCurve(to: CGPoint(x: 12.7, y: 8.5), controlPoint1: CGPoint(x: 13.1, y: 7), controlPoint2: CGPoint(x: 12.5, y: 7.8))
    path.addCurve(to: CGPoint(x: 8.4, y: 7.6), controlPoint1: CGPoint(x: 13.1, y: 9.8), controlPoint2: CGPoint(x: 9, y: 11))
    path.addCurve(to: CGPoint(x: 8.8, y: 6), controlPoint1: CGPoint(x: 8.2, y: 6.7), controlPoint2: CGPoint(x: 8.4, y: 6.5))
    path.addCurve(to: CGPoint(x: 9.2, y: 5.2), controlPoint1: CGPoint(x: 9, y: 5.8), controlPoint2: CGPoint(x: 9.2, y: 5.5))
    path.addCurve(to: CGPoint(x: 8, y: 4), controlPoint1: CGPoint(x: 9.2, y: 4.5), controlPoint2: CGPoint(x: 8.6, y: 4))
    path.addCurve(to: CGPoint(x: 6.8, y: 5.2), controlPoint1: CGPoint(x: 7.4, y: 4), controlPoint2: CGPoint(x: 6.8, y: 4.5))
    path.addCurve(to: CGPoint(x: 7.2, y: 6), controlPoint1: CGPoint(x: 6.8, y: 5.5), controlPoint2: CGPoint(x: 7, y: 5.8))
    path.addCurve(to: CGPoint(x: 7.6, y: 7.6), controlPoint1: CGPoint(x: 7.6, y: 6.5), controlPoint2: CGPoint(x: 7.7, y: 6.7))
    path.addCurve(to: CGPoint(x: 3.3, y: 8.5), controlPoint1: CGPoint(x: 7, y: 11), controlPoint2: CGPoint(x: 2.9, y: 9.8))
    path.addCurve(to: CGPoint(x: 2.2, y: 7), controlPoint1: CGPoint(x: 3.5, y: 7.8), controlPoint2: CGPoint(x: 2.9, y: 7))
    path.addCurve(to: CGPoint(x: 1, y: 8.2), controlPoint1: CGPoint(x: 1.5, y: 7), controlPoint2: CGPoint(x: 1, y: 7.5))
    path.addCurve(to: CGPoint(x: 2.3, y: 9.4), controlPoint1: CGPoint(x: 1, y: 8.9), controlPoint2: CGPoint(x: 1.6, y: 9.5))
    path.addCurve(to: CGPoint(x: 3.9, y: 13), controlPoint1: CGPoint(x: 3.3, y: 9.3), controlPoint2: CGPoint(x: 3.9, y: 12))
    path.addLine(to: CGPoint(x: 12.1, y: 13))
    path.addCurve(to: CGPoint(x: 13.7, y: 9.4), controlPoint1: CGPoint(x: 12.1, y: 12), controlPoint2: CGPoint(x: 12.7, y: 9.3))
    path.addCurve(to: CGPoint(x: 15, y: 8.2), controlPoint1: CGPoint(x: 14.4, y: 9.5), controlPoint2: CGPoint(x: 15, y: 8.9))
    path.addCurve(to: CGPoint(x: 13.8, y: 7), controlPoint1: CGPoint(x: 15, y: 7.5), controlPoint2: CGPoint(x: 14.5, y: 7))
    path.close()

    return path
  }()
  
  let arrow: UIBezierPath = {
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 13.3, y: 10.9))
    path.addCurve(to: CGPoint(x: 13.3, y: 10.1), controlPoint1: CGPoint(x: 13.7, y: 10.7), controlPoint2: CGPoint(x: 13.7, y: 10.3))
    path.addLine(to: CGPoint(x: 9.7, y: 8))
    path.addCurve(to: CGPoint(x: 8.9, y: 8.4), controlPoint1: CGPoint(x: 9.3, y: 7.8), controlPoint2: CGPoint(x: 8.9, y: 8))
    path.addLine(to: CGPoint(x: 8.9, y: 12.6))
    path.addCurve(to: CGPoint(x: 9.7, y: 13), controlPoint1: CGPoint(x: 8.9, y: 13), controlPoint2: CGPoint(x: 9.3, y: 13.2))
    path.addLine(to: CGPoint(x: 13.3, y: 10.9))
    path.close()
    path.move(to: CGPoint(x: 3.2, y: 9.7))
    path.addCurve(to: CGPoint(x: 2.4, y: 10.5), controlPoint1: CGPoint(x: 2.8, y: 9.7), controlPoint2: CGPoint(x: 2.4, y: 10.1))
    path.addCurve(to: CGPoint(x: 3.2, y: 11.3), controlPoint1: CGPoint(x: 2.4, y: 10.9), controlPoint2: CGPoint(x: 2.8, y: 11.3))
    path.addLine(to: CGPoint(x: 3.2, y: 11.3))
    path.addCurve(to: CGPoint(x: 4, y: 10.5), controlPoint1: CGPoint(x: 3.6, y: 11.3), controlPoint2: CGPoint(x: 4, y: 10.9))
    path.addCurve(to: CGPoint(x: 3.2, y: 9.7), controlPoint1: CGPoint(x: 4, y: 10.1), controlPoint2: CGPoint(x: 3.6, y: 9.7))
    path.addLine(to: CGPoint(x: 3.2, y: 9.7))
    path.close()
    path.move(to: CGPoint(x: 5.5, y: 9.7))
    path.addCurve(to: CGPoint(x: 4.7, y: 10.5), controlPoint1: CGPoint(x: 5, y: 9.7), controlPoint2: CGPoint(x: 4.7, y: 10.1))
    path.addCurve(to: CGPoint(x: 5.5, y: 11.3), controlPoint1: CGPoint(x: 4.7, y: 10.9), controlPoint2: CGPoint(x: 5, y: 11.3))
    path.addLine(to: CGPoint(x: 5.5, y: 11.3))
    path.addCurve(to: CGPoint(x: 6.3, y: 10.5), controlPoint1: CGPoint(x: 5.9, y: 11.3), controlPoint2: CGPoint(x: 6.3, y: 10.9))
    path.addCurve(to: CGPoint(x: 5.5, y: 9.7), controlPoint1: CGPoint(x: 6.3, y: 10.1), controlPoint2: CGPoint(x: 5.9, y: 9.7))
    path.addLine(to: CGPoint(x: 5.5, y: 9.7))
    path.close()
    path.move(to: CGPoint(x: 7.7, y: 9.7))
    path.addCurve(to: CGPoint(x: 6.9, y: 10.5), controlPoint1: CGPoint(x: 7.3, y: 9.7), controlPoint2: CGPoint(x: 6.9, y: 10.1))
    path.addCurve(to: CGPoint(x: 7.7, y: 11.3), controlPoint1: CGPoint(x: 6.9, y: 10.9), controlPoint2: CGPoint(x: 7.3, y: 11.3))
    path.addLine(to: CGPoint(x: 7.7, y: 11.3))
    path.addCurve(to: CGPoint(x: 8.5, y: 10.5), controlPoint1: CGPoint(x: 8.2, y: 11.3), controlPoint2: CGPoint(x: 8.5, y: 10.9))
    path.addCurve(to: CGPoint(x: 7.7, y: 9.7), controlPoint1: CGPoint(x: 8.5, y: 10.1), controlPoint2: CGPoint(x: 8.2, y: 9.7))
    path.addLine(to: CGPoint(x: 7.7, y: 9.7))
    path.close()

    return path
  }()
  
  let skull: UIBezierPath = {
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 8, y: 5.7))
    path.addCurve(to: CGPoint(x: 3.8, y: 9.9), controlPoint1: CGPoint(x: 5.7, y: 5.7), controlPoint2: CGPoint(x: 3.8, y: 7.6))
    path.addCurve(to: CGPoint(x: 6, y: 13.7), controlPoint1: CGPoint(x: 3.8, y: 11.5), controlPoint2: CGPoint(x: 4.7, y: 12.9))
    path.addLine(to: CGPoint(x: 6, y: 14.9))
    path.addCurve(to: CGPoint(x: 7, y: 15.5), controlPoint1: CGPoint(x: 6.3, y: 15.4), controlPoint2: CGPoint(x: 7, y: 15.5))
    path.addLine(to: CGPoint(x: 7, y: 14.5))
    path.addLine(to: CGPoint(x: 7.5, y: 14.5))
    path.addLine(to: CGPoint(x: 7.5, y: 15.5))
    path.addLine(to: CGPoint(x: 8.5, y: 15.5))
    path.addLine(to: CGPoint(x: 8.5, y: 14.5))
    path.addLine(to: CGPoint(x: 9, y: 14.5))
    path.addLine(to: CGPoint(x: 9, y: 15.5))
    path.addCurve(to: CGPoint(x: 10, y: 14.9), controlPoint1: CGPoint(x: 9, y: 15.5), controlPoint2: CGPoint(x: 9.7, y: 15.4))
    path.addLine(to: CGPoint(x: 10, y: 13.7))
    path.addCurve(to: CGPoint(x: 12.2, y: 9.9), controlPoint1: CGPoint(x: 11.3, y: 12.9), controlPoint2: CGPoint(x: 12.2, y: 11.5))
    path.addCurve(to: CGPoint(x: 8, y: 5.7), controlPoint1: CGPoint(x: 12.2, y: 7.6), controlPoint2: CGPoint(x: 10.3, y: 5.7))
    path.close()
    path.move(to: CGPoint(x: 6, y: 11.5))
    path.addCurve(to: CGPoint(x: 4.8, y: 10.3), controlPoint1: CGPoint(x: 5.3, y: 11.5), controlPoint2: CGPoint(x: 4.8, y: 10.9))
    path.addCurve(to: CGPoint(x: 6, y: 9), controlPoint1: CGPoint(x: 4.8, y: 9.6), controlPoint2: CGPoint(x: 5.3, y: 9))
    path.addCurve(to: CGPoint(x: 7.3, y: 10.3), controlPoint1: CGPoint(x: 6.7, y: 9), controlPoint2: CGPoint(x: 7.3, y: 9.6))
    path.addCurve(to: CGPoint(x: 6, y: 11.5), controlPoint1: CGPoint(x: 7.3, y: 10.9), controlPoint2: CGPoint(x: 6.7, y: 11.5))
    path.close()
    path.move(to: CGPoint(x: 7, y: 12.5))
    path.addLine(to: CGPoint(x: 8, y: 11.2))
    path.addLine(to: CGPoint(x: 9, y: 12.5))
    path.addLine(to: CGPoint(x: 7, y: 12.5))
    path.close()
    path.move(to: CGPoint(x: 10, y: 11.5))
    path.addCurve(to: CGPoint(x: 8.8, y: 10.3), controlPoint1: CGPoint(x: 9.3, y: 11.5), controlPoint2: CGPoint(x: 8.8, y: 10.9))
    path.addCurve(to: CGPoint(x: 10, y: 9), controlPoint1: CGPoint(x: 8.8, y: 9.6), controlPoint2: CGPoint(x: 9.3, y: 9))
    path.addCurve(to: CGPoint(x: 11.3, y: 10.3), controlPoint1: CGPoint(x: 10.7, y: 9), controlPoint2: CGPoint(x: 11.3, y: 9.6))
    path.addCurve(to: CGPoint(x: 10, y: 11.5), controlPoint1: CGPoint(x: 11.3, y: 10.9), controlPoint2: CGPoint(x: 10.7, y: 11.5))
    path.close()
    path.move(to: CGPoint(x: 12.3, y: 13))
    path.addLine(to: CGPoint(x: 14, y: 14.7))
    path.addLine(to: CGPoint(x: 12.7, y: 16))
    path.addLine(to: CGPoint(x: 10.9, y: 14.3))
    path.addCurve(to: CGPoint(x: 12.3, y: 13), controlPoint1: CGPoint(x: 11.5, y: 13.9), controlPoint2: CGPoint(x: 11.9, y: 13.5))
    path.close()
    path.move(to: CGPoint(x: 3.7, y: 7))
    path.addLine(to: CGPoint(x: 2, y: 5.3))
    path.addLine(to: CGPoint(x: 3.3, y: 4))
    path.addLine(to: CGPoint(x: 5, y: 5.7))
    path.addCurve(to: CGPoint(x: 3.7, y: 7), controlPoint1: CGPoint(x: 4.5, y: 6), controlPoint2: CGPoint(x: 4, y: 6.5))
    path.close()
    path.move(to: CGPoint(x: 11, y: 5.7))
    path.addLine(to: CGPoint(x: 12.7, y: 4))
    path.addLine(to: CGPoint(x: 14, y: 5.3))
    path.addLine(to: CGPoint(x: 12.3, y: 7))
    path.addCurve(to: CGPoint(x: 11, y: 5.7), controlPoint1: CGPoint(x: 12, y: 6.5), controlPoint2: CGPoint(x: 11.5, y: 6))
    path.close()
    path.move(to: CGPoint(x: 5.1, y: 14.3))
    path.addLine(to: CGPoint(x: 3.3, y: 16))
    path.addLine(to: CGPoint(x: 2, y: 14.7))
    path.addLine(to: CGPoint(x: 3.7, y: 13))
    path.addCurve(to: CGPoint(x: 5.1, y: 14.3), controlPoint1: CGPoint(x: 4.1, y: 13.5), controlPoint2: CGPoint(x: 4.5, y: 13.9))
    path.close()

    return path
  }()

}
