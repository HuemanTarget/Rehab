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
        List {
          HStack {
            MedicationImageView()
            VStack(alignment: .leading, spacing: 2) {
              HStack {
                Text("Pill name")
                  .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                
                Spacer()
                
                Button(action: {
                  // Add 30 to quantity
                }) {
                  Text("Refill")
                    .padding(10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                }
              }
              Text("Pill shape / Pill Color / Pill logo")
                .font(.subheadline)
              HStack {
                Text("30 remaining")
                Button(action: {
                  //Add 1 to pills quantity
                }) {
                  Image(systemName: "plus.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .background(Circle().fill(Color.green))
                    .frame(width: 35, height: 35)
                } //: PLUS BUTTON
                Text("-")
                Button(action: {
                  //Minus 1 to pill quantity
                }) {
                  Image(systemName: "minus.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .background(Circle().fill(Color.red))
                    .frame(width: 35, height: 35)
                } //: MINUS BUTTON
              }
            }
          }
        }
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
