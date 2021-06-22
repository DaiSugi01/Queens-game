//
//  CommonViewController.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-06-09.
//

import UIKit

/// All Queens games view controller must have background view.
protocol QueensGameViewControllerProtocol where Self: UIViewController{
  var backgroundCreator: BackgroundCreator {get set}
}
