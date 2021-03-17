//
//  EKCalendarExtension.swift
//  Rehab
//
//  Created by Joshua Basche on 3/16/21.
//

import SwiftUI
import EventKit

extension EKCalendar: Identifiable {
  public var id: String {
    return self.calendarIdentifier
  }
  
  public var color: Color {
    return Color(UIColor(cgColor: self.cgColor))
  }
  
  public var formattedText: Text {
    return Text("•\u{00a0}")
      .font(.headline)
      .foregroundColor(self.color)
      + Text("\(self.title)")
  }
}
