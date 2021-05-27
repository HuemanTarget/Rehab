//
//  Color+Extensions.swift
//  Rehab
//
//  Created by Joshua Basche on 5/27/21.
//

import Foundation
import SwiftUI

extension Color {
  static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
  
  static let lightStart = Color(red: 60 / 255, green: 160 / 255, blue: 240 / 255)
  static let lightEnd = Color(red: 30 / 255, green: 80 / 255, blue: 120 / 255)
  
  public static var lairBackgroundGray: Color {
    Color(.lairBackgroundGray)
  }
  
  public static var lairDarkGray: Color {
    Color(.lairDarkGray)
  }
  
  public static var lairShadowGray: Color {
    Color(.lairShadowGray)
  }
  
  public static var lairGray: Color {
    Color(.lairGray)
  }
  
  public static var lairLightGray: Color {
    Color(.lairLightGray)
  }
  
  public static var lairWhite: Color {
    Color(.lairWhite)
  }
}
