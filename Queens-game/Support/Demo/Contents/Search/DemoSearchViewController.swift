//
//  DemoSearchViewController.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-28.
//

import UIKit


/// ⚠️ This is a demo ViewController. Do not use this class in release version.
///
/// This controller shows the usage of
/// 1. CustomSearchBar
/// 2. CustomSegmentedView
class DemoSearchViewController: UIViewController {

  var searchBar: UISearchBar!
  
  /*
   How to use: CustomSegmentedView.
  
   You pass two parameters, "title" and [IconType].
   You can just copy paste this.
  */
  var difficultySegmentedControlView = CustomSegmentedView(
    "Difficulty",
    [.levelOne, .levelTwo, .levelThree]
  )
  var commandTypeSegmentedControlView = CustomSegmentedView(
    "Type       ",
    [.cToC, .cToA, .cToQ]
  )

  override func viewDidLoad() {
    super.viewDidLoad()
    view.configBgColor(bgColor:  CustomColor.background)
    configSearchBar()

    
    let stackView = VerticalStackView(
      arrangedSubviews: [
        searchBar,
        difficultySegmentedControlView,
        commandTypeSegmentedControlView
      ],
      spacing: 32
    )
    stackView.configLayout(superView: view, width: 360)
    stackView.centerXYin(view)
  }
  
}

extension DemoSearchViewController: UISearchBarDelegate {
  // have to create after view did load. Otherwise, it won't reflect the place holder UI
  func configSearchBar(){
    
    /*
     How to use: CustomSearchBar.
    
     You don't have to pass any data.
     But you "must create it in viewDidLoad", not in init().
    */
    searchBar = CustomSearchBar()
    
    searchBar.delegate = self
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    print(searchText)
  }
}
