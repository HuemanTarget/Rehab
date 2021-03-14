//
//  ContentView.swift
//  Rehab
//
//  Created by Joshua Basche on 3/14/21.
//

import SwiftUI

struct ContentView: View {
  // MARK: - PROPERTIES
  
  // MARK: - BODY
  var body: some View {
    TabView {
      CalendarView()
        .tabItem {
          Label("Calendar", systemImage: "calendar")
        }
      
      MedicationView()
        .tabItem {
          Label("Medication", systemImage: "pills")
        }
      
      JournalView()
        .tabItem {
          Label("Journal", systemImage: "book.closed")
        }
    } //: TABVIEW
  }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
