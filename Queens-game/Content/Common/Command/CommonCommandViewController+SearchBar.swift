//
//  CommandSettingViewController+SearchBar.swift
//  Queens-game
//
//  Created by Takayuki Yamaguchi on 2021-05-11.
//

import UIKit

extension CommonCommandViewController: UISearchBarDelegate {
  
  // Whenever Text is changed
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    viewModel.searchText = searchText
    viewModel.readItems()
  }
  
  // Enter clicked
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    // Stop focus
    searchBar.resignFirstResponder()
  }
  
  // Before Start editing
  func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
    
    // reveal mask
    UIView.animate( withDuration: 0.24, delay: 0, options: .curveEaseIn)
    { [unowned self] in
      self.searchBarMask.alpha = 0.4
    }
    // show cancel button
    searchBar.setShowsCancelButton(true, animated: true)
    return true
  }
  
  // Before End edit
  func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
    // hide cancel button
    searchBar.setShowsCancelButton(false, animated: true)
    searchBar.resignFirstResponder()
    
    // hide and disable mask
    UIView.animate( withDuration: 0.24, delay: 0, options: .curveEaseIn)
    { [unowned self] in
      self.searchBarMask.alpha = 0
    }
    return true
  }

  // If cancel is clicked, hide it.
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    // Hide cancel button
    searchBar.setShowsCancelButton(false, animated: true)
    // Reset text to "" and search, so that all items will be displayed
    searchBar.text = nil
    searchBar.delegate?.searchBar?(searchBar, textDidChange: "")
    
    // Quit focus
    searchBar.resignFirstResponder()
  }
  
  // Display search bar if search bottom icon is tapped.
  @objc func searchButtonTapped() {
    UIView.animate( withDuration: 0.24, delay: 0, options: .curveEaseIn)
    { [unowned self] in
      self.searchBar.isHidden = false
      self.searchBar.alpha = 1
      self.searchBarMask.alpha = 0.4
      searchBar.becomeFirstResponder()
    }
  }
  
  @objc func maskTapped() {
    searchBar.endEditing(true)
  }
}

