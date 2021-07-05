//
//  ScreenSelectionViewModel.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-07-04.
//

import UIKit
import RxSwift

class ScreenSelectionViewModel {
  let disposeBag = DisposeBag()
  
  func loadScreen(_ window: UIWindow, _ navigationController: UINavigationController, _ index: Int) {
    
    let loadingView = LoadingView()
    loadingView.alpha = 0
    loadingView.frame = window.frame
    window.addSubview(loadingView)
    
    UIView.animate(withDuration: 0.24, delay: 0, options: .curveEaseInOut) {
      loadingView.alpha = 1
    } completion: {  _ in
      
      switch Constant.ScreenSelection.Index(rawValue: index) {
        case .home:
          GameManager.shared.loadGameProgress(to: .home, with: navigationController)
        case .queen:
          GameManager.shared.loadGameProgress(to: .queenSelection, with: navigationController)
        case .command:
          GameManager.shared.loadGameProgress(to: .commandSelection, with: navigationController)
        case .none:
          print("no page")
          GameManager.shared.loadGameProgress(to: .home, with: navigationController)
      }
      
      UIView.animate(withDuration: 0.6, delay: 0, options: .beginFromCurrentState) {
        loadingView.icon.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
      } completion: { _ in
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut) {
          loadingView.alpha = 0
        } completion: { _ in
          loadingView.removeFromSuperview()
        }
      }
    }
    
  }
  
  deinit {
    print("\(Self.self) is being deinitialized")
  }
}
