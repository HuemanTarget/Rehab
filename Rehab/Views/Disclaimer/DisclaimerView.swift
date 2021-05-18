//
//  DisclaimerView.swift
//  Rehab
//
//  Created by Joshua Basche on 4/12/21.
//

import SwiftUI

struct DisclaimerView: View {
  // MARK: - PROPERTIES
  @Environment(\.managedObjectContext) var managedObjectContext
  @Environment(\.presentationMode) var presentationMode
  
  @State private var acceptTerms: Bool = false
  
  @State private var errorShowing: Bool = false
  @State private var errorTitle: String = ""
  @State private var errorMessage: String = ""
  
  let hapticImpact = UIImpactFeedbackGenerator(style: .medium)
  
  // MARK: - BODY
  var body: some View {
    VStack {
      Spacer()
      
      Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
        .padding(40)
        .font(.title3)
      
      
      Button(action: {

        acceptTerms = true
        
        if self.acceptTerms != false {
//          let disclaimer = Disclaimer(context: self.managedObjectContext)
          
//          disclaimer.disclaimer = self.acceptTerms
          
          do {
            try self.managedObjectContext.save()
            
          } catch {
            print(error)
          }
          
        } else {
          self.errorShowing = true
          self.errorTitle = "Terms Not Accepted"
          self.errorMessage = "Please accept the terms\nto open the application."
          
          return
        } //: CONDITIONAL
        hapticImpact.impactOccurred()
        self.presentationMode.wrappedValue.dismiss()
      }) {
        Text("Save Journal Entry")
          .font(.system(size: 20, weight: .bold, design: .default))
          .padding(20)
          .frame(minWidth: 0, maxWidth: .infinity)
          .background(Color("SpaceCadet"))
          .cornerRadius(9)
          .foregroundColor(.white)
      } //: BUTTON
      
      Spacer()
    } //: VSTACK
    .padding(.horizontal)
    .padding(.vertical, 10)
  }
}

// MARK: - PREVIEW
struct DisclaimerView_Previews: PreviewProvider {
  static var previews: some View {
    DisclaimerView()
  }
}
