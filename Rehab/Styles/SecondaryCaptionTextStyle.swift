//
//  SecondaryCaptionTextStyle.swift
//  Rehab
//
//  Created by Joshua Basche on 3/16/21.
//

import Foundation
import SwiftUI

struct SecondaryCaptionTextStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.caption)
      .foregroundColor(.secondary)
  }
}
