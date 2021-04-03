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
  
  @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
  
  @State private var date = Date()
  @State private var desc: String = ""
  @State private var hr: String = ""
  @State private var bp: String = ""
  @State private var bpd: String = ""
  @State private var pain: String = "N/A"
  @State private var notes: String = ""
  @State private var temperature: String = ""
  @State private var tempType: String = "F"
  @State private var oxygen: String = ""
  
  @State private var errorShowing: Bool = false
  @State private var errorTitle: String = ""
  @State private var errorMessage: String = ""
  
  @State private var value: CGFloat = 0
  
  let painLevels = ["N/A", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
  
  let temps = ["F", "C"]
  
  // MARK: - BODY
  var body: some View {
    NavigationView {
      ScrollView {
        VStack(alignment: .leading, spacing: 20) {
          
          // Date
//          DatePicker("Journal Entry", selection: $date)
//            .padding(.top, 10)
          
          // Description
          TextField("Journal Description", text: $desc)
            .padding(10)
            .background(Color(UIColor.tertiarySystemFill))
            .cornerRadius(9)
            .font(.system(size: 24, weight: .bold, design: .default))

          
          // Heart Rate
          HStack {
            TextField("Heart Rate", text: $hr)
              .padding(10)
              .background(Color(UIColor.tertiarySystemFill))
              .cornerRadius(9)
              .font(.system(size: 24, weight: .bold, design: .default))
              .keyboardType(.numberPad)
            
            TextField("Oxygen %", text: $oxygen)
              .padding(10)
              .background(Color(UIColor.tertiarySystemFill))
              .cornerRadius(9)
              .font(.system(size: 24, weight: .bold, design: .default))
              .keyboardType(.numberPad)
          }
          
          // Blood Pressure
          HStack {
            TextField("BP - Systolic", text: $bp)
              .padding(10)
              .background(Color(UIColor.tertiarySystemFill))
              .cornerRadius(9)
              .font(.system(size: 20, weight: .bold, design: .default))
              .keyboardType(.numberPad)
            
            Text(" / ")
            
            TextField("BP - Diastolic", text: $bpd)
              .padding(10)
              .background(Color(UIColor.tertiarySystemFill))
              .cornerRadius(9)
              .font(.system(size: 20, weight: .bold, design: .default))
              .keyboardType(.numberPad)
          }
          
          // Temperature
          HStack {
            TextField("Temperature", text: $temperature)
              .padding(10)
              .background(Color(UIColor.tertiarySystemFill))
              .cornerRadius(9)
              .font(.system(size: 20, weight: .bold, design: .default))
              .keyboardType(.numberPad)
            
            Picker("Dosage Measurement", selection: $tempType) {
              ForEach(temps, id: \.self) { temp in
                Text("\(temp)").tag(temp)
              }
            }
            .frame(height: 20)
            .pickerStyle(SegmentedPickerStyle())
            .scaledToFit()
            .scaleEffect(CGSize(width: 1.8, height: 1.5))
            
          }
          
          // Pain
          Text("Pain Level 1(low) - 10(high)")
          Picker("Pain", selection: $pain) {
            ForEach(painLevels, id: \.self) {
              Text($0)
            }
          }
          .pickerStyle(SegmentedPickerStyle())
          .padding(0)
          
          
          // Misc Notes
          TextField("Misc Notes", text: $notes)
            .padding(40)
            .background(Color(UIColor.tertiarySystemFill))
            .cornerRadius(9)
            .font(.system(size: 24, weight: .bold, design: .default))
            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
          
          // Save Button
          Button(action: {
            if self.hr == "" {
              hr = "N/A"
            } else {
              hr = "\(hr) bpm"
            }
            
            if self.bp == "" && self.bpd == "" {
              bp = "-"
              bpd = "-"
            }
            
            if self.temperature == "" {
              temperature = "N/A"
            }
            
            if self.oxygen == "" {
              oxygen = "N/A"
            }
            
//            if self.bpd == "" {
//              bpd = "N/A"
//            }
            
            if self.notes == "" {
              notes = "N/A"
            }
            
            
            if self.desc != "" {
              let journal = Journal(context: self.managedObjectContext)
              journal.date = self.date
              journal.desc = self.desc
              journal.hr = self.hr
              journal.bp = self.bp
              journal.bpd = self.bpd
              journal.pain = self.pain
              journal.notes = self.notes
              journal.temperature = self.temperature
              journal.oxygen = self.oxygen
              journal.tempType = self.tempType
              journal.id = UUID()
              
              do {
                try self.managedObjectContext.save()
                self.desc = ""
                self.hr = ""
                self.bp = ""
                self.bpd = ""
                self.notes = ""
                self.temperature = ""
                self.oxygen = ""
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
              .font(.system(size: 20, weight: .bold, design: .default))
              .padding(20)
              .frame(minWidth: 0, maxWidth: .infinity)
              .background(Color("SpaceCadet"))
              .cornerRadius(9)
              .foregroundColor(.white)
          } //: BUTTON
        } //: VSTACK
        .padding(.horizontal)
        .padding(.vertical, 10)
        
        Spacer()
      } //: SCROLL
//      .keyboardAdaptive()
      .navigationBarTitle("New Journal Entry", displayMode: .inline)
      .navigationBarColor(UIColor(red: 43, green: 45, blue: 66))
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
