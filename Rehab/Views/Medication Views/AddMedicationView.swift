//
//  AddMedicationView.swift
//  Rehab
//
//  Created by Joshua Basche on 3/17/21.
//

import SwiftUI

struct AddMedicationView: View {
  // MARK: - PROPERTIES
  @Environment(\.managedObjectContext) var managedObjectContext
  @Environment(\.presentationMode) var presentationMode
  
  @State private var name: String = ""
  @State private var shape: String = ""
  @State private var color: String = ""
  @State private var logo: String = ""
  @State private var quantity: Int = 0
  
  @State private var errorShowing: Bool = false
  @State private var errorTitle: String = ""
  @State private var errorMessage: String = ""
  
  let shapes = [String]()
  
  // MARK: - BODY
  var body: some View {
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
  }
}

// MARK: - PREVIEW
struct AddMedicationView_Previews: PreviewProvider {
  static var previews: some View {
    AddMedicationView()
  }
}
