//
//  BellSettingsView.swift
//  Rehab
//
//  Created by Joshua Basche on 3/22/21.
//

import SwiftUI

struct BellSettingsView: View {
  // MARK: - PROPERTIES
  @Environment(\.managedObjectContext) var managedObjectContext
  @Environment(\.presentationMode) var presentationMode
  
  @State private var phoneNumber: String = ""
  @State private var message: String = ""
  
  @State private var errorShowing: Bool = false
  @State private var errorTitle: String = ""
  @State private var errorMessage: String = ""
  
  // MARK: - BODY
  var body: some View {
    NavigationView {
      VStack {
        VStack(alignment: .leading, spacing: 20) {
          TextField("Phone Number With County Code", text: $phoneNumber)
            .padding(5)
            .background(Color(UIColor.tertiarySystemFill))
            .cornerRadius(9)
            .font(.system(size: 20, weight: .bold, design: .default))
          
          TextField("Message", text: $message)
            .padding(5)
            .background(Color(UIColor.tertiarySystemFill))
            .cornerRadius(9)
            .font(.system(size: 20, weight: .bold, design: .default))
          
          Button(action: {
            
            if self.phoneNumber != "" {
              let bell = Bell(context: self.managedObjectContext)
              bell.phoneNumber = self.phoneNumber
              bell.message = self.message
              bell.id = UUID()
              
              do {
                try self.managedObjectContext.save()
                self.phoneNumber = ""
                self.message = ""
              } catch {
                print(error)
              }
              
            } else {
              self.errorShowing = true
              self.errorTitle = "Invalid Phone Number"
              self.errorMessage = "Please enter a phone number\ncountry code first."
              
              return
            } //: CONITIONAL
            self.presentationMode.wrappedValue.dismiss()
          }) {
            Text("Save Message Info")
              .font(.system(size: 20, weight: .bold, design: .default))
              .padding(10)
              .frame(minWidth: 0, maxWidth: .infinity)
              .background(Color.blue)
              .cornerRadius(9)
              .foregroundColor(.white)
          } //: BUTTON
          
          
          Spacer()
        } //: VSTACK
        .padding(.horizontal)

      } //: VSTACK
    } //: NAVIGATION
  }
}

// MARK: - PREVIEW
struct BellSettingsView_Previews: PreviewProvider {
  static var previews: some View {
    BellSettingsView()
  }
}
