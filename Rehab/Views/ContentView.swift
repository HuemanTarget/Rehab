//
//  ContentView.swift
//  Rehab
//
//  Created by Joshua Basche on 3/14/21.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
  // MARK: - PROPERTIES
  @State private var isUnlocked = false
  
  @FetchRequest(entity: Disclaimer.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Disclaimer.disclaimer, ascending: false)]) var disclaimer: FetchedResults<Disclaimer>
  
  // MARK: - BODY
  var body: some View {
    VStack {

        TabBarView()

    }
    
//    ZStack {
//      if isUnlocked || LAContext() == .none {
//        TabBarView()
//      } else {
////        AppLockView()
//        Button(action: {
//          self.authenticate()
//        }) {
//          VStack {
//            Image(systemName: "faceid")
//              .padding(5)
//              .font(.system(size: 75))
//              .foregroundColor(Color("ImperialRed"))
//            Text("Unlock Rehab")
//              .font(.title3)
//              .fontWeight(.bold)
//              .foregroundColor(Color("ImperialRed"))
//          }
//          .frame(maxWidth: .infinity, maxHeight: .infinity)
//          .background(Color("SpaceCadet"))
//          .edgesIgnoringSafeArea(.all)
//        }
//      }
//    } //: ZSTACK
  }
  
  //: FUNCTIONS
//  func authenticate() {
//    let context = LAContext()
//    var error: NSError?
//    
//    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
//      let reason = "Please authenticate yourself to unlock Rehab."
//      
//      context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
//        
//        DispatchQueue.main.async {
//          if success {
//            self.isUnlocked = true
//          } else {
//            // error
//          }
//        }
//      }
//    } else {
//      // no biometrics
////      self.isUnlocked = true
//    }
//  }
  
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
