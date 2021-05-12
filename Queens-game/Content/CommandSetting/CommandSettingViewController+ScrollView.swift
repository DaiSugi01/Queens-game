//
//  CommandSettingViewController+ScrollView.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-11.
//

import UIKit

extension CommandSettingViewController: UICollectionViewDelegate{
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    
    // Only allow large Dragging
    if !decelerate { return }
    
    // Scroll up == drag down. Show search bar.
    if(scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 0) {
      UIView.animate(withDuration: 0.24, delay: 0, options: .curveEaseIn)
      { [unowned self] in
        self.searchBar.isHidden = false
        self.searchBar.alpha = 1
      }
    }
    // Scroll down == drag up. Hide search bar.
    else {
      UIView.animate(withDuration: 0.24, delay: 0, options: .curveEaseOut)
      { [unowned self] in
        self.searchBar.alpha = 0
      } completion: { [unowned self] _ in
        // After finish being invisible search bar, completely disable it.
        self.searchBar.isHidden = true
      }
    }
  }
}
