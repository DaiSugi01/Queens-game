//
//  ViewController.swift
//  UISample
//
//  Created by Takayuki Yamaguchi on 2021-04-16.
//

import UIKit


/// ⚠️ This page is Top view of UI demos. Do not use this class in release version
///
/// This view controller and any other view controllers proceeding to this view are "not" going to be used in release version.
class DemoViewController: UITableViewController {
  let sectionName = ["Color + Rect","Fonts","Buttons", "Icons", "Cell", "Search"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = CustomColor.background
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "demo")
  }

}

extension DemoViewController {
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    1
  }
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    sectionName.count
  }
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: "demo")
    cell.textLabel?.text = sectionName[indexPath.row]
    return cell
  }
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let nextVC: UIViewController
    
    // Link to another demo view controller
    switch sectionName[indexPath.row] {
      case "Color + Rect":
        nextVC = DemoColorViewController()
      case "Fonts":
        nextVC = DemoFontViewController()
      case "Buttons":
        nextVC = DemoButtonViewController()
      case "Icons":
        nextVC = DemoIconViewController()
      case "Cell":
        nextVC = DemoCellCollectionViewController()
      case "Search":
        nextVC = DemoSearchViewController()
      default:
       return
    }
    
    navigationController?.pushViewController(nextVC, animated: true)
  }
}

