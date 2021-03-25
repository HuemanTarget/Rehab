//
//  AppLockView.swift
//  Rehab
//
//  Created by Joshua Basche on 3/25/21.
//

import SwiftUI

struct AppLockView: View {
  // MARK: - PROPERTIES
  @EnvironmentObject var appLockVM: AppLockViewModel
  
  // MARK: - BODY
  var body: some View {
    VStack(spacing: 30) {
      Image(systemName: "lock.circle")
        .resizable()
        .frame(width: 100, height: 100, alignment: .center)
        .foregroundColor(.red)
      
      Text("App Locked")
        .font(.title)
        .foregroundColor(.red)
      
      Button("Open") {
        appLockVM.appLockValidation()
      }
      .foregroundColor(.primary)
      .padding(.horizontal, 30)
      .padding(.vertical, 15)
      .background(
        RoundedRectangle(cornerRadius: 8)
          .stroke(Color.red)
        
      )
      Spacer(minLength: 0)
    }.padding(.top, 50)
  }
}

// MARK: - PREVIEW
struct AppLockView_Previews: PreviewProvider {
  static var previews: some View {
    AppLockView()
  }
}
