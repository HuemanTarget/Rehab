//
//  MedicationView.swift
//  Rehab
//
//  Created by Joshua Basche on 3/14/21.
//

import SwiftUI

struct MedicationView: View {
  // MARK: - PROPERTIES
  @Environment(\.managedObjectContext) var managedObjectContext
  
  @FetchRequest(entity: Pill.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Pill.name, ascending: true)]) var pills: FetchedResults<Pill>
  
  @State private var showingAddPillView: Bool = false
  
  // MARK: - BODY
  var body: some View {
    NavigationView {
      ZStack {
        Text("Hello World")
      } //: ZSTACK
      .sheet(isPresented: $showingAddPillView) {
        AddMedicationView().environment(\.managedObjectContext, self.managedObjectContext)
      }
      .overlay(
        ZStack {
          Group {
            Circle()
              .fill(Color.blue)
              .opacity(0.2)
              .frame(width: 68, height: 68, alignment: .center)
            Circle()
              .fill(Color.blue)
              .opacity(0.15)
              .frame(width: 88, height: 88, alignment: .center)
          } //: GROUP

          Button(action: {
            self.showingAddPillView.toggle()
          }) {
            Image(systemName: "pills.fill")
              .resizable()
              .scaledToFit()
              .background(Circle().fill(Color("ColorBase")))
              .frame(width: 48, height: 48, alignment: .center)
          }
        } //: ZSTACK
        .padding(.bottom, 15)
        .padding(.trailing, 15)
        , alignment: .bottomTrailing
      ) //: OVERLAY
    } //: NAVIGATION
  }
}

// MARK: - PREVIEW
struct MedicationView_Previews: PreviewProvider {
  static var previews: some View {
    MedicationView()
  }
}
