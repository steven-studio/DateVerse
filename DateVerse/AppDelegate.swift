//
//  AppDelegate.swift
//  DateVerse
//
//  Created by 游哲維 on 2025/3/5.
//

import UIKit
import SwiftUI
import FirebaseCore // 重要！
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // ❶ 建立要共享的 ObservableObject 實例（放成屬性，確保生命週期不會提早釋放）
    let appState = AppState()
    let userSettings = UserSettings()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()  // ← 加入這行即可解決問題！
        GMSServices.provideAPIKey("AIzaSyDSElQ4T5wywLZ-HlqJ3kXOI8wpNX0qF8s") // 替换成你自己的 API Key

        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()
            .environmentObject(appState)
            .environmentObject(userSettings)

        // Use a UIHostingController as window root view controller.
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIHostingController(rootView: contentView)
        self.window = window
        window.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }


}

