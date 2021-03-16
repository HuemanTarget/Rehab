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
  @State private var notes: String = ""
  
  let painLevels = ["N/A", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
  
  // MARK: - BODY
  var body: some View {
    NavigationView {
      VStack {
        VStack(alignment: .leading, spacing: 20) {
          
          // Date
          DatePicker("Journal Entry Date", selection: $date)
            .padding()
          
          // Description
          TextField("Journal Description", text: $desc)
            .padding()
            .background(Color(UIColor.tertiarySystemFill))
            .cornerRadius(9)
            .font(.system(size: 24, weight: .bold, design: .default))
          
          
          // Heart Rate
          TextField("Heart Rate - BPM", text: $hr)
            .padding()
            .background(Color(UIColor.tertiarySystemFill))
            .cornerRadius(9)
            .font(.system(size: 24, weight: .bold, design: .default))
          
          // Blood Pressure
          TextField("Blood Pressure - Systolic / Diastolic", text: $bp)
            .padding()
            .background(Color(UIColor.tertiarySystemFill))
            .cornerRadius(9)
            .font(.system(size: 24, weight: .bold, design: .default))
          
          // Pain
          Text("Pain Level 1(low) - 10(high)")
            .padding(.leading)
            .padding(.bottom, 0)
          Picker("Pain", selection: $pain) {
            ForEach(painLevels, id: \.self) {
              Text($0)
            }
          }
          .pickerStyle(SegmentedPickerStyle())
          .padding()
          .padding(.top, 0)
          
          // Misc Notes
          TextField("Misc Notes", text: $notes)
            .padding(30)
            .background(Color(UIColor.tertiarySystemFill))
            .cornerRadius(9)
            .font(.system(size: 24, weight: .bold, design: .default))
          
          // Save Button
          Button(action: {
            // Code Here
          }) {
            Text("Save Entry")
          }
        } //: VSTACK
        Spacer()
      } //: VSTACK
      .navigationBarTitle("New Journal Entry", displayMode: .inline)
    } //: NAVIGATION
  }
}

// MARK: - PREVIEW
struct AddJournalView_Previews: PreviewProvider {
  static var previews: some View {
    AddJournalView()
  }
}
