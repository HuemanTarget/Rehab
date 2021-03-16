//
//  AddJournalView.swift
//  Rehab
//
//  Created by Joshua Basche on 3/15/21.
//

import SwiftUI

struct AddJournalView: View {
  // MARK: - PROPERTIES
  @Environment(\.managedObjectContext) var managedObjectContext
  @Environment(\.presentationMode) var presentationMode
  
  @State private var date = Date()
  @State private var desc: String = ""
  @State private var hr: String = ""
  @State private var bp: String = ""
  @State private var pain: String = "N/A"
  
  
  let painLevels = ["N/A", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
  
  // MARK: - BODY
  var body: some View {
    NavigationView {
      VStack(alignment: .center, spacing: 10) {
        Form {
          // Date
          Section(header: Text("Journal Date")) {
            
          }
          
          // Description
          Section(header: Text("Journal Description")) {
            TextField("Description", text: $desc)
              .padding(8)
              .cornerRadius(9)
              .font(.system(size: 20, weight: .bold, design: .default))
          }
          
          // Heart Rate
          Section(header: Text("Heart Rate")) {
            TextField("BPM", text: $hr)
              .padding(8)
              .cornerRadius(9)
              .font(.system(size: 20, weight: .bold, design: .default))
          }
          
          // Blood Pressure
          Section(header: Text("Blood Pressure")) {
            TextField("Systolic / Diastolic", text: $bp)
              .padding(8)
              .cornerRadius(9)
              .font(.system(size: 20, weight: .bold, design: .default))
          }
          
          // Pain
          Section(header: Text("Pain Level: 1(low) - 10(high)")) {
            Picker("Pain", selection: $pain) {
              ForEach(painLevels, id: \.self) {
                Text($0)
              }
            }
            .pickerStyle(DefaultPickerStyle())
            .padding(8)
          }
        } //: FORM
      } //: VSTACK
    } //: NAVIGATION
  }
}

// MARK: - PREVIEW
struct AddJournalView_Previews: PreviewProvider {
  static var previews: some View {
    AddJournalView()
  }
}
