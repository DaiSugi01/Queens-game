//
//  CommandSettingViewController+SearchBar.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-11.
//

import UIKit

extension CommonCommandViewController: UISearchBarDelegate {
  
  // Text change
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    viewModel.searchText = searchText
    viewModel.readItems()
  }
  // Enter clicked
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    // Stop focus
    searchBar.resignFirstResponder()
  }
  
  // Start edit
  func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
    // show cancel button
    searchBar.setShowsCancelButton(true, animated: true)
    return true
  }
  // End edit
  func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
    // hide cancel button
    searchBar.setShowsCancelButton(false, animated: true)
    return true
  }
  // If cancel is clicked, hide it.
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    // Stop focus
    searchBar.resignFirstResponder()
    // Hide cancel button
    searchBar.setShowsCancelButton(false, animated: true)
    // Reset text to "" and search, so that all items will be displayed
    searchBar.text = nil
    searchBar.delegate?.searchBar?(searchBar, textDidChange: "")
  }
  
  // Display search bar if search bottom icon is tapped.
  @objc func searchButtonTapped() {
    UIView.animate( withDuration: 0.24, delay: 0, options: .curveEaseIn)
    { [unowned self] in
      self.searchBar.isHidden = false
      self.searchBar.alpha = 1
      searchBar.becomeFirstResponder()
    }
  }
}