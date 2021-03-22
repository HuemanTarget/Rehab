//
//  MedicationImageView.swift
//  Rehab
//
//  Created by Joshua Basche on 3/22/21.
//

import SwiftUI

struct MedicationImageView: View {
  // MARK: - PROPERTIES
  @State private var image: Image? = Image(systemName: "photo")
  @State private var shouldPresentImagePicker = false
  @State private var shouldPresentActionSheet = false
  @State private var shouldPresentCamera = false
  
  // MARK: - BODY
  var body: some View {
    image!
      .resizable()
      .scaledToFit()
//      .aspectRatio(contentMode: .fill)
//      .frame(width: 300, height: 300)
      .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
      .overlay(Circle().stroke(Color.white, lineWidth: 4))
      .shadow(radius: 10)
      .onTapGesture {
        self.shouldPresentActionSheet = true
      }
      .sheet(isPresented: self.$shouldPresentImagePicker) {
        SUImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary, image: self.$image, isPresented: self.$shouldPresentImagePicker)
      }
      .actionSheet(isPresented: $shouldPresentActionSheet) { () -> ActionSheet in
        ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
          self.shouldPresentImagePicker = true
          self.shouldPresentCamera = true
        }), ActionSheet.Button.default(Text("Photo Library"), action: {
          self.shouldPresentImagePicker = true
          self.shouldPresentCamera = false
        }), ActionSheet.Button.cancel()])
      }
  }
}

// MARK: - PREVIEW
struct MedicationImageView_Previews: PreviewProvider {
  static var previews: some View {
    MedicationImageView()
  }
}
