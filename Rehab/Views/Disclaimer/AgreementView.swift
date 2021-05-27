//
//  AgreementView.swift
//  Rehab
//
//  Created by Joshua Basche on 5/27/21.
//

import SwiftUI

struct AgreementView: View {
  @State var showDetail: Bool = false
  @State private var displayPopupMessage: Bool = true
  
  var body: some View {
    VStack {
      NavigationLink(destination: ContentView(), isActive: self.$showDetail) { ContentView() }
      Button(action: {
        self.displayPopupMessage = true
        // self.showDetail = true
        // self.displayPopupMessage = self.prepossess()
      } )
      {
        Text("Alert and Navigate")
      }
    }
    .alert(isPresented: $displayPopupMessage){
      Alert(title: Text("Warning"), message: Text("This is a test"), dismissButton: .default(Text("OK"), action: {
        print("Ok Click")
        self.showDetail = true
      })
      )
    }
  }
}

struct AgreementView_Previews: PreviewProvider {
  static var previews: some View {
    AgreementView()
  }
}
