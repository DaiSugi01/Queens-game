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
    
    // If text is empty -> This is executed when "x" button is click. We want to stop focus.
    if searchText.isEmpty {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            searchBar.resignFirstResponder()
        }
    }
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
    {
      self.searchBarMask.alpha = 0.6
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
    {
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
}

extension CommonCommandViewController {
  
  /// Display search bar if search bottom icon is tapped.
  func configureSearchButtonBinding() {
    searchButton.rx.tap
      .bind{ [weak self] in
        guard let self = self else { return }
        UIView.animate( withDuration: 0.24, delay: 0, options: .curveEaseIn)
        { 
          self.searchBar.isHidden = false
          self.searchBar.alpha = 1
          self.searchBarMask.alpha = 0.6
          self.searchBar.becomeFirstResponder()
        }
      }
      .disposed(by: viewModel.disposeBag)
  }
}
