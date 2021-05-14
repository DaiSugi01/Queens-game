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
    viewModel.filterItems(searchText)
  }
  // Enter clicked
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    // Stop focus
    searchBar.resignFirstResponder()
  }
  
  // Start edit
  func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
    searchBar.setShowsCancelButton(true, animated: true)
    return true
  }
  // End edit
  func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
    searchBar.setShowsCancelButton(false, animated: true)
    return true
  }
  // If cancel is clicked, hide it.
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    // Stop focus
    searchBar.resignFirstResponder()
    // Hide cancel button
    searchBar.setShowsCancelButton(false, animated: true)
    // Reset text and display full items
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
