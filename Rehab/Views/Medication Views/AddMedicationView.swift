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
  @State private var pillQuantity: String = ""
  
  @State private var errorShowing: Bool = false
  @State private var errorTitle: String = ""
  @State private var errorMessage: String = ""
  
  let shapes = [ "capsule", "circular", "gell", "long-split", "oval-split" ]
  
  // MARK: - BODY
  var body: some View {
    NavigationView {
      VStack {
        VStack(alignment: .leading, spacing: 20) {
          
          // Name
          TextField("Name", text: $name)
            .padding(5)
            .background(Color(UIColor.tertiarySystemFill))
            .cornerRadius(9)
            .font(.system(size: 20, weight: .bold, design: .default))
            .padding(.top, 5)

          
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
            .padding(5)
            .background(Color(UIColor.tertiarySystemFill))
            .cornerRadius(9)
            .font(.system(size: 20, weight: .bold, design: .default))
          
          // Logo
          TextField("Logo", text: $logo)
            .padding(5)
            .background(Color(UIColor.tertiarySystemFill))
            .cornerRadius(9)
            .font(.system(size: 20, weight: .bold, design: .default))
          
          // Quantity
          TextField("Quantity", text: $pillQuantity)
            .padding(5)
            .background(Color(UIColor.tertiarySystemFill))
            .cornerRadius(9)
            .font(.system(size: 20, weight: .bold, design: .default))
            .keyboardType(.numberPad)
          
          // Save Button
          Button(action: {
            if self.name != "" {
              let pill = Pill(context: self.managedObjectContext)
              pill.name = self.name
              pill.shape = self.shape
              pill.color = self.color
              pill.logo = self.logo
              pill.pillQuantity = self.pillQuantity
              pill.id = UUID()
              
              do {
                try self.managedObjectContext.save()
                self.name = ""
                self.color = ""
                self.logo = ""
                self.pillQuantity = ""
              } catch {
                print(error)
              }
    
            } else {
              self.errorShowing = true
              self.errorTitle = "Invalid Medication Name"
              self.errorMessage = "Please enter something for\nthe medication name."
              
              return
            } //: CONDITIONAL
            self.presentationMode.wrappedValue.dismiss()
          }) {
            Text("Save Medication")
              .font(.system(size: 20, weight: .bold, design: .default))
              .padding(10)
              .frame(minWidth: 0, maxWidth: .infinity)
              .background(Color("SpaceCadet"))
              .cornerRadius(9)
              .foregroundColor(.white)
          } //: BUTTON
        } //: VSTACK
        .padding(.horizontal)
        .padding(.vertical, 10)
        
        Spacer()
      } //: VSTACK
      .keyboardAdaptive()
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
