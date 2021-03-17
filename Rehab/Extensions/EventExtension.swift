//
//  EventExtension.swift
//  Rehab
//
//  Created by Joshua Basche on 3/16/21.
//

import EventKit
import SwiftUI

extension EKEvent {
  var color: Color {
    return Color(UIColor(cgColor: self.calendar.cgColor))
  }
}
