//
//  View+Extensions.swift
//  Rehab
//
//  Created by Joshua Basche on 5/27/21.
//

import Foundation
import SwiftUI

extension View {
  func inverseMask<Mask>(_ mask: Mask) -> some View where Mask : View {
    self.mask(mask
      .foregroundColor(.black)
      .background(Color.white)
      .compositingGroup()
      .luminanceToAlpha()
    )
  }
}
