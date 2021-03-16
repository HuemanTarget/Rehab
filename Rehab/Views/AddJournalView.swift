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
  
  @State private var errorShowing: Bool = false
  @State private var errorTitle: String = ""
  @State private var errorMessage: String = ""
  
  let painLevels = ["N/A", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
  
  // MARK: - BODY
  var body: some View {
    NavigationView {
      VStack {
        VStack(alignment: .leading, spacing: 20) {
          
          // Date
          DatePicker("Journal Entry", selection: $date)
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
            if self.desc != "" {
              let journal = Journal(context: self.managedObjectContext)
              journal.date = self.date
              journal.desc = self.desc
              journal.hr = self.hr
              journal.bp = self.bp
              journal.pain = self.pain
              journal.notes = self.notes
              journal.id = UUID()
              
              do {
                try self.managedObjectContext.save()
                print("date: \(date), description: \(desc), HR: \(hr), BP: \(bp), pain: \(pain), notes: \(notes)")
                self.desc = ""
                self.hr = ""
                self.bp = ""
                self.pain = "N/A"
                self.notes = ""
              } catch {
                print(error)
              }
    
            } else {
              self.errorShowing = true
              self.errorTitle = "Invalid Journal Description"
              self.errorMessage = "Please enter something for\nthe journal description."
              
              return
            } //: CONDITIONAL
            self.presentationMode.wrappedValue.dismiss()
          }) {
            Text("Save Journal Entry")
              .font(.system(size: 24, weight: .bold, design: .default))
              .padding()
              .frame(minWidth: 0, maxWidth: .infinity)
              .background(Color.blue)
              .cornerRadius(9)
              .foregroundColor(.white)
          } //: BUTTON
        } //: VSTACK
        .padding(.horizontal)
        .padding(.vertical, 10)
        
        Spacer()
      } //: VSTACK
      .navigationBarTitle("New Journal Entry", displayMode: .inline)
      .navigationBarItems(
        trailing:
          Button(action: {
            presentationMode.wrappedValue.dismiss()
          }) {
            Image(systemName: "xmark")
          }
      )
      .alert(isPresented: $errorShowing) {
        Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
      }
    } //: NAVIGATION
  }
}

// MARK: - PREVIEW
struct AddJournalView_Previews: PreviewProvider {
  static var previews: some View {
    AddJournalView()
  }
}
