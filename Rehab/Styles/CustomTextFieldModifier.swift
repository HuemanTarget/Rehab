//
//  CustomTextFieldModifier.swift
//  Rehab
//
//  Created by Joshua Basche on 5/27/21.
//

import Foundation
import SwiftUI

struct CustomTextFieldModifier: ViewModifier {
  func body(content: Content) -> some View {
    content.background(Color.white)
      .cornerRadius(15)
      .overlay(
        RoundedRectangle(cornerRadius: 15)
          .stroke(Color.black.opacity(0.05), lineWidth: 4)
          .shadow(color: Color.black.opacity(0.2), radius: 6, x: 6, y: 6)
          .clipShape(RoundedRectangle(cornerRadius: 15))
          .shadow(color: Color.black.opacity(0.2), radius: 6, x: -6, y: -6)
          .clipShape(RoundedRectangle(cornerRadius: 15))
      )
  }
}
