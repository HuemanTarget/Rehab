//
//  AuthenticationView.swift
//  Rehab
//
//  Created by Joshua Basche on 5/27/21.
//

import SwiftUI
import LocalAuthentication

struct AuthenticationView: View {
  @State var isActive = false
  @State var isUnlocked: Bool = false
  @State var noAuth: Bool = false
  @State private var willMoveToNextScreen = false
  
  //  init() {
  //    UITableView.appearance().separatorStyle = .none
  ////    UITableView.appearance().backgroundColor = .clear
  ////    UITableViewCell.appearance().backgroundColor = UIColor(Color.red)
  //    UINavigationBar.appearance().backgroundColor = .clear
  //    UITableView.appearance().backgroundColor = UIColor(Color.lairBackgroundGray)
  //  }
  
  var body: some View {
    
      ZStack {
        Color.lairBackgroundGray.edgesIgnoringSafeArea(.all)
        VStack {
          VStack {
//            Text("Please Log Into Rehab \n using FaceID")
//              .padding(.bottom, 30)
//              .multilineTextAlignment(.center)
//              .font(.title)
            
            if isUnlocked {
              ContentView()
            } else {
              VStack {
                Button(action: {
                  auth()
                }) {
                  Image(systemName: "faceid")
                    .font(.system(size: 50))
                    .foregroundColor(.black)
                }
                .softButtonStyle(RoundedRectangle(cornerRadius: 20))

   

                  Button(action: {
                    isUnlocked = true
      
                    }) {
                      Text("Press To Enter \n Without FaceID")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .frame(minWidth: 0, maxWidth: 200, minHeight: 50)
                    }
                    .softButtonStyle(RoundedRectangle(cornerRadius: 20))
                  .padding(.top, 30)
              }
            }
            
  //          if noAuth {
  //            Button(action: {
  //              willMoveToNextScreen = true
  //
  //            }) {
  //              Text("Press To Enter \n Without Authentication")
  //                .multilineTextAlignment(.center)
  //                .foregroundColor(.black)
  //                .frame(minWidth: 0, maxWidth: 200, minHeight: 50)
  //            }
  //            .softButtonStyle(RoundedRectangle(cornerRadius: 20))
  //            .padding(.top, 30)
  //
  //          }
          }
  //        .navigate(to: ContentView(), when: $willMoveToNextScreen)
        }
    }
    
  }
  
  func auth() {
    let context = LAContext()
    var error: NSError?
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
      let reason = "We need your biometics authentication to enter the app."
      context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
        DispatchQueue.main.async {
          if success {
            isUnlocked = true
          } else {
            print("You are not the owner!")
          }
        }
      }
    } else {
      noAuth = true
    }
  }
}

extension View {
  
  /// Navigate to a new view.
  /// - Parameters:
  ///   - view: View to navigate to.
  ///   - binding: Only navigates when this condition is `true`.
  func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
    NavigationView {
      ZStack {
        self
          .navigationBarTitle("")
          .navigationBarHidden(true)
        
        NavigationLink(
          destination: view
            .navigationBarTitle("")
            .navigationBarHidden(true),
          isActive: binding
        ) {
          EmptyView()
        }
      }
    }
  }
}

struct AuthenticationView_Previews: PreviewProvider {
  static var previews: some View {
    AuthenticationView()
  }
}
