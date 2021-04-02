//
//  CheckboxStyle.swift
//  Rehab
//
//  Created by Joshua Basche on 4/2/21.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
  
  func makeBody(configuration: Self.Configuration) -> some View {
    
    return HStack {
      
      configuration.label
      
      Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
        .resizable()
        .frame(width: 24, height: 24)
        .foregroundColor(configuration.isOn ? .green : .gray)
        .font(.system(size: 20, weight: .bold, design: .default))
        .onTapGesture {
          configuration.isOn.toggle()
        }
    }
    
  }
}

