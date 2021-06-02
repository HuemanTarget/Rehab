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
  @State private var shape: String = "nopill"
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
  
  let shapes = [ "nopill", "capsule", "circular", "gell", "long-split", "oval-split" ]
  
  let mesurements = [ "mg", "mL" ]
  
  let hapticImpact = UIImpactFeedbackGenerator(style: .medium)
  
  // MARK: - BODY
  var body: some View {
    NavigationView {
      Form {
        VStack(alignment: .leading, spacing: 20) {
          
          // Name
          TextField("Name", text: $name)
            .padding(10)
            .background(Color(UIColor.tertiarySystemFill))
            .cornerRadius(9)
            .modifier(CustomTextFieldModifier())
//            .font(.system(size: 24, weight: .bold, design: .default))
            .padding(.top, 5)
          
          // Dosage
          HStack {
            TextField("Dosage", text: $dosage)
              .padding(10)
              .background(Color(UIColor.tertiarySystemFill))
              .cornerRadius(9)
              .modifier(CustomTextFieldModifier())
//              .font(.system(size: 24, weight: .bold, design: .default))
              .padding(.top, 5)
              .keyboardType(.decimalPad)
            
            Spacer()
            
            Picker("Dosage Measurement", selection: $dosageMeasurement) {
              ForEach(mesurements, id: \.self) { dose in
                Text("\(dose)").tag(dose)
              }
            }
//            .frame(height: 20)
            .pickerStyle(SegmentedPickerStyle())
            .modifier(CustomTextFieldModifier())
            .scaledToFit()
            .scaleEffect(CGSize(width: 1.4, height: 1.5))
          }
          
          // Shape
//          Text("Pill Shape:")
//            .padding(.top, 0)
//          Picker("Pain", selection: $shape) {
//            ForEach(shapes, id: \.self) { shape in
//              Image("\(shape)").tag(shape)
//                .onTapGesture {
//                  hapticImpact.impactOccurred()
//                }
//            }
//          }
//          .frame(height: 40)
//          .pickerStyle(SegmentedPickerStyle())
//          .scaledToFit()
//          .scaleEffect(CGSize(width: 1, height: 2.0))
//          .padding(.top, 5)
//          .padding(.bottom, 5)
          
          // Color
//          TextField("Color", text: $color)
//            .padding(10)
//            .background(Color(UIColor.tertiarySystemFill))
//            .cornerRadius(9)
//            .font(.system(size: 24, weight: .bold, design: .default))
//
          // Logo
          HStack {
            TextField("Per Dose", text: $usage)
              .padding(10)
              .background(Color(UIColor.tertiarySystemFill))
              .cornerRadius(9)
              .modifier(CustomTextFieldModifier())
//              .font(.system(size: 20, weight: .bold, design: .default))
              .keyboardType(.decimalPad)
            
            Toggle(isOn: $morning) {
              Text("Morning")
                .font(.subheadline)
                .onTapGesture {
                  hapticImpact.impactOccurred()
                }
            }
            .toggleStyle(CheckboxStyle())
            
            
            Toggle(isOn: $noon) {
              Text("Noon")
                .font(.subheadline)
                .onTapGesture {
                  hapticImpact.impactOccurred()
                }
            }
            .toggleStyle(CheckboxStyle())
            
            
            Toggle(isOn: $night) {
              Text("Night")
                .font(.subheadline)
                .onTapGesture {
                  hapticImpact.impactOccurred()
                }
              
            }
            .toggleStyle(CheckboxStyle())
          }
          
          // Quantity
          TextField("Quantity", text: $pillQuantity)
            .padding(10)
            .background(Color(UIColor.tertiarySystemFill))
            .cornerRadius(9)
            .modifier(CustomTextFieldModifier())
//            .font(.system(size: 24, weight: .bold, design: .default))
            .keyboardType(.numberPad)
          
          // Save Button
          Button(action: {
            if self.pillQuantity == "" {
              pillQuantity = "0"
            }
            
            if self.color == "" {
              color = "N/A"
            }
            
            if self.dosage == "" {
              dosage = "N/A"
            }
            
            if self.usage == "" {
              usage = "N/A"
            }
            
            
            if self.name != "" {
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
              self.errorTitle = "Invalid Medication Name"
              self.errorMessage = "Please enter something for\nthe medication name."
              
              return
            } //: CONDITIONAL
            hapticImpact.impactOccurred()
            self.presentationMode.wrappedValue.dismiss()
          }) {
            Text("Save Medication")
              .bold()
              .foregroundColor(.green)
//              .font(.system(size: 20, weight: .bold, design: .default))

              .frame(minWidth: 0, maxWidth: .infinity)
//              .cornerRadius(9)
          } //: BUTTON
          .softButtonStyle(RoundedRectangle(cornerRadius: 20))
        
          HStack {
            Spacer()
            
            Button(action: {
              presentationMode.wrappedValue.dismiss()
            }) {
              Text("Close")
                .bold()
                .foregroundColor(.red)
                .frame(minWidth: 0, maxWidth: 100)
            }
            .softButtonStyle(RoundedRectangle(cornerRadius: 20))
            
            Spacer()
          }
          .padding(.top)
          .padding(.bottom)  
          
        } //: VSTACK
//        .padding(.horizontal)
        .padding(.vertical, 10)
        
        
        
      } //: SCROLL
      //      .keyboardAdaptive()
//      .navigationBarTitle("New Medication")
      .navigationBarTitle("")
      .navigationBarHidden(true)
//      .navigationBarColor(UIColor(red: 43, green: 45, blue: 66))
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
