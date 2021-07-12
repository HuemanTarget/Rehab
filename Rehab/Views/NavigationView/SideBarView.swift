//
//  SideBarView.swift
//  Rehab
//
//  Created by Joshua Basche on 7/12/21.
//

import SwiftUI

struct SideBarView: View {
  var body: some View {
    NavigationView {
      List {
        NavigationLink(
          destination: CalendarView(),
          label: {
            Label("Calendar", systemImage: "calendar")
          })
        NavigationLink(
          destination: MedicationView(),
          label: {
            Label("Calendar", systemImage: "pills")
          })
        NavigationLink(
          destination: JournalView(),
          label: {
            Label("Calendar", systemImage: "book.closed")
          })
      }
      .navigationTitle("Rehab")
      .listStyle(SidebarListStyle())
    }
  }
}

struct SideBarView_Previews: PreviewProvider {
  static var previews: some View {
    SideBarView()
  }
}
