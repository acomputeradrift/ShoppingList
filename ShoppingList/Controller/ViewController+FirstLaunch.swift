//
//  ViewController+FirstLaunch.swift
//  ShoppingList
//
//  Created by Nathan Wainwright on 2018-08-26.
//  Copyright © 2018 Jamie. All rights reserved.
//

import Foundation

final class FirstLaunch {
  
  let userDefaults: UserDefaults = .standard
  
  let wasLaunchedBefore: Bool
  var isFirstLaunch: Bool {
    return !wasLaunchedBefore
  }
  
  init() {
    let key = "com.any-suggestion.FirstLaunch.WasLaunchedBefore"
    let wasLaunchedBefore = userDefaults.bool(forKey: key)
    self.wasLaunchedBefore = wasLaunchedBefore
    if !wasLaunchedBefore {
      userDefaults.set(true, forKey: key)
    }
  }
  
} // END -- FirstLaunch
