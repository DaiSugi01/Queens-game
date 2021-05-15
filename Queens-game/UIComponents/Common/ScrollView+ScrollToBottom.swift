//
//  ScrollView+ScrollToBottom.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-12.
//

import UIKit

extension UIScrollView {
    func scrollToBottom(animated: Bool) {
        let y = contentSize.height - 1
        let rect = CGRect(x: 0, y: y + safeAreaInsets.bottom, width: 1, height: 1)
        scrollRectToVisible(rect, animated: animated)
    }
}
