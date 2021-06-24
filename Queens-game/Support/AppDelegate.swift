//
//  AppDelegate.swift
//  Queens-game
//
//  Created by 杉原大貴 on 2021/03/08.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    initCommand()
    return true
  }
  
  // MARK: UISceneSession Lifecycle
  
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
  
  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }
  
}


// MARK: - Custom configuration

extension AppDelegate {
  /// Fill sample data of command, if there is no items.
  private func initCommand() {
    let realm = try! Realm()
    let restoredItems = realm.objects(Command.self)
    
    // If there is no item, fill sample data.
    if restoredItems.count == 0 {
      // Because of reference type, we create copy objects (other wise sample date is also deleted when you delete from the list.)
      let initialCopy = CommandViewModel.samples.map {Command(value: $0)}
      // Save them.
      try! realm.write {
        realm.add(initialCopy)
      }
    }
  }
}

