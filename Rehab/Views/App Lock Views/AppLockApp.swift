//
//  AppLockApp.swift
//  Rehab
//
//  Created by Joshua Basche on 3/25/21.
//

import SwiftUI

@main
struct AppLockApp: App {
  // MARK: - PROPERTIES
  @StateObject var appLockVM = AppLockViewModel()
  @Environment(\.scenePhase) var scenePhase
  
  @State var blurRadius: CGFloat = 0
  
  // MARK: - BODY
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(appLockVM)
        .blur(radius: blurRadius)
        .onChange(of: scenePhase, perform: { value in
          switch value {
          case .active :
            blurRadius = 0
          case .background:
            appLockVM.isAppUnLocked = false
          case .inactive:
            blurRadius = 5
          @unknown default:
            print("unknown")
          }
        })
    }
  }
}
