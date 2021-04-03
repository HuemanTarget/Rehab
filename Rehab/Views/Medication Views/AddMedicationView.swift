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
  
  @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 2)
  
  @State private var name: String = ""
  @State private var shape: String = ""
  @State private var color: String = ""
  @State private var usage: String = ""
  @State private var pillQuantity: String = ""
  @State private var dosage: String = ""
  @State private var dosageMeasurement: String = "mg"
  @State private var morning: Bool = false
  @State private var noon: Bool = false
  @State private var night: Bool = false
  
  @State private var errorShowing: Bool = false
  @State private var errorTitle: String = ""
  @State private var errorMessage: String = ""
  
  @State private var value: CGFloat = 0
  
  let shapes = [ "capsule", "circular", "gell", "long-split", "oval-split" ]
  
  let mesurements = [ "mg", "mL" ]
  
  // MARK: - BODY
  var body: some View {
    NavigationView {
      ScrollView {
        VStack(alignment: .leading, spacing: 20) {
          
          // Name
          TextField("Name", text: $name)
            .padding(10)
            .background(Color(UIColor.tertiarySystemFill))
            .cornerRadius(9)
            .font(.system(size: 24, weight: .bold, design: .default))
            .padding(.top, 5)
          
          // Dosage
          HStack {
            TextField("Dosage", text: $dosage)
              .padding(10)
              .background(Color(UIColor.tertiarySystemFill))
              .cornerRadius(9)
              .font(.system(size: 24, weight: .bold, design: .default))
              .padding(.top, 5)
              .keyboardType(.numberPad)
            
            Spacer()
            
            Picker("Dosage Measurement", selection: $dosageMeasurement) {
              ForEach(mesurements, id: \.self) { dose in
                Text("\(dose)").tag(dose)
              }
            }
            .frame(height: 20)
            .pickerStyle(SegmentedPickerStyle())
            .scaledToFit()
            .scaleEffect(CGSize(width: 1.8, height: 1.65))
          }
          
          // Shape
          Text("Pill Shape:")
            .padding(.top, 0)
          Picker("Pain", selection: $shape) {
            ForEach(shapes, id: \.self) { shape in
              Image("\(shape)").tag(shape)
            }
          }
          .frame(height: 40)
          .pickerStyle(SegmentedPickerStyle())
          .scaledToFit()
          .scaleEffect(CGSize(width: 1, height: 2.0))
          .padding(.top, 5)
          .padding(.bottom, 5)
          
          // Color
          TextField("Color", text: $color)
            .padding(10)
            .background(Color(UIColor.tertiarySystemFill))
            .cornerRadius(9)
            .font(.system(size: 24, weight: .bold, design: .default))
          
          // Logo
          HStack {
            TextField("Per Dose", text: $usage)
              .padding(10)
              .background(Color(UIColor.tertiarySystemFill))
              .cornerRadius(9)
              .font(.system(size: 20, weight: .bold, design: .default))
              .keyboardType(.numberPad)
            
            Toggle(isOn: $morning) {
              Text("Morning")
                .font(.subheadline)
            }
            .toggleStyle(CheckboxStyle())
            
            Toggle(isOn: $noon) {
              Text("Noon")
                .font(.subheadline)
            }
            .toggleStyle(CheckboxStyle())
            
            Toggle(isOn: $night) {
              Text("Night")
                .font(.subheadline)
              
            }
            .toggleStyle(CheckboxStyle())
          }
          
          // Quantity
          TextField("Quantity", text: $pillQuantity)
            .padding(10)
            .background(Color(UIColor.tertiarySystemFill))
            .cornerRadius(9)
            .font(.system(size: 24, weight: .bold, design: .default))
            .keyboardType(.numberPad)
          
          // Save Button
          Button(action: {
            if self.name != "" && self.pillQuantity != "" {
              let pill = Pill(context: self.managedObjectContext)
              pill.name = self.name
              pill.shape = self.shape
              pill.color = self.color
              pill.usage = self.usage
              pill.pillQuantity = self.pillQuantity
              pill.dosage = self.dosage
              pill.dosageMeasurement = self.dosageMeasurement
              pill.morning = self.morning
              pill.noon = self.noon
              pill.night = self.night
              pill.id = UUID()
              
              do {
                try self.managedObjectContext.save()
                self.name = ""
                self.color = ""
                self.usage = ""
                self.pillQuantity = ""
                self.dosage = ""
                self.morning = false
                self.noon = false
                self.night = false
              } catch {
                print(error)
              }
              
            } else {
              self.errorShowing = true
              self.errorTitle = "Invalid Medication Name and Pill Quantity"
              self.errorMessage = "Please enter something for\nthe medication name and pill quantity."
              
              return
            } //: CONDITIONAL
            self.presentationMode.wrappedValue.dismiss()
          }) {
            Text("Save Medication")
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
      .navigationBarTitle("New Medication", displayMode: .inline)
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
struct AddMedicationView_Previews: PreviewProvider {
  static var previews: some View {
    AddMedicationView()
  }
}
