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
          ForEach(self.pills, id: \.self) { pill in
            HStack {
              VStack(alignment: .leading, spacing: 2) {
                HStack {
                  Text(pill.name ?? "Unkown")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                  
                  Spacer()
                  
                  Button(action: {
                    print("Refill Hit")
                  }) {
                    Text("Refill")
                      .padding(8)
                      .background(Color.blue)
                      .foregroundColor(.white)
                      .clipShape(RoundedRectangle(cornerRadius: 5))
                  }
                }
                HStack {
                  Image(pill.shape!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                  
                  Spacer()
                  
                  Text("Color: \(pill.color ?? "N/A")")
                    .font(.subheadline)
                    .fontWeight(.bold)
                  
                  Spacer()
                  
                  Text("Logo: \(pill.logo ?? "N/A")")
                    .font(.subheadline)
                    .fontWeight(.bold)
                }
                HStack {
                  Text("\(pill.pillQuantity ?? "Unkown") pills remaining")
                  
                  Spacer()
                  
                  Button(action: {
                    print("plus hit")
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
                    print("minus hit")
                  }) {
                    Image(systemName: "minus.circle")
                      .resizable()
                      .scaledToFit()
                      .foregroundColor(.white)
                      .background(Circle().fill(Color.red))
                      .frame(width: 35, height: 35)
                  } //: MINUS BUTTON
                } //: HSTACK
              } //: VSTACK
            } //: HSTACK
          } //: FOREACH
          .onDelete(perform: deletePill)
        } //: LIST
        .navigationBarTitle("Medication", displayMode: .inline)
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
  
  private func deletePill(at offsets: IndexSet) {
    for index in offsets {
      let pill = pills[index]
      managedObjectContext.delete(pill)
      
      do {
        try managedObjectContext.save()
      } catch {
        print(error)
      }
    }
  }
  
}

// MARK: - PREVIEW
struct MedicationView_Previews: PreviewProvider {
  static var previews: some View {
    MedicationView()
  }
}
