//
//  MenuAnimatedTransitioning.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-06-21.
//

import UIKit

// Transition animation
class PopUpTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
  
  let duration = 0.2
  var presenting = true
  
  /// Singleton object. Because this animation is reusable.
  static let shared = PopUpTransitioning()
  private override init() {}
  
  // Animation duration
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    duration
  }
  
  // Animation behavior
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    // container that used in animation
    let containerView = transitionContext.containerView
    
    if self.presenting {
      
      // The actual view used in transition.  If presenting, it'll be `.to` in transitionContext.
      // presenting:  nil -----> .to
      let animationView = transitionContext.view(forKey: .to)!
      containerView.addSubview(animationView)
      
      // The start status of the view.
      animationView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
      animationView.alpha = 0.0
      containerView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
      
      // The end status of the view.
      UIView.animate(
        withDuration: duration,
        delay: 0,
        options: .curveEaseOut,
        animations: {
          animationView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
          animationView.alpha = 1.0
          containerView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        },
        completion: { _ in
          transitionContext.completeTransition(true)
        }
      )
      
    } else {
      
      // The actual view used in transition.  If not presenting (dismissing), it'll be `.from` in transitionContext.
      // presenting:  .from <----- .to
      let animationView = transitionContext.view(forKey: .from)!
      containerView.addSubview(animationView)
      
      // The start status of the view.
      animationView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
      animationView.alpha = 1.0
      containerView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
      
      // The end status of the view.
      UIView.animate(
        withDuration: duration,
        delay: 0,
        options: .curveEaseOut,
        animations: {
          animationView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
          animationView.alpha = 0.0
          containerView.alpha = 0.0
        },
        completion: { _ in
          transitionContext.completeTransition(true)
        }
      )
      
    }
  }
}


// The delegatee who will do the transition. We will send this to the delegator.
class PopUpTransitioningDelegatee: NSObject, UIViewControllerTransitioningDelegate { }

extension PopUpTransitioningDelegatee {
  // Tells delegate What kind if animation transitioning do you want to use when presenting ?
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

    PopUpTransitioning.shared.presenting = true
    return PopUpTransitioning.shared
  }

  // Tells delegate What kind if animation transitioning do you want to use when dismissing ?
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    PopUpTransitioning.shared.presenting = false
    return PopUpTransitioning.shared
  }
}
