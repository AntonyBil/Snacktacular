//
//  SnacktacularApp.swift
//  Snacktacular
//
//  Created by apple on 31.10.2023.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct SnacktacularApp: App {
    // register app delegate for Firebase setup
      @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
      @StateObject var spotVM = ReviewViewModel()
      @StateObject var locationManager = LocationManager()

    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(spotVM)
                .environmentObject(locationManager)
        }
    }
}
