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
  @Environment(\.presentationMode) var presentationMode
  
  @FetchRequest(entity: Pill.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Pill.name, ascending: true)]) var pills: FetchedResults<Pill>
  
  @State private var showingAddPillView: Bool = false
  
  @State private var errorShowing: Bool = false
  @State private var errorTitle: String = ""
  @State private var errorMessage: String = ""
  
  let hapticImpact = UIImpactFeedbackGenerator(style: .medium)
  
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
                    .font(.title2)
                    .fontWeight(.bold)
                  
                  Text(" - ")
                    .font(.title)
                    .fontWeight(.bold)
                  
                  Text(pill.dosage ?? "Unkown")
                    .font(.subheadline)
                    .fontWeight(.bold)
                  Text(pill.dosageMeasurement ?? "Unkown")
                    .font(.subheadline)
                    .fontWeight(.bold)
                  
                  Spacer()
                  
                  Button(action: {
                    let quantity = Int(pill.pillQuantity!)
                    let refill = String(quantity! + 30)
                    
                    pill.pillQuantity = refill
                    
                    hapticImpact.impactOccurred()
                    
                    do {
                      try self.managedObjectContext.save()
                    } catch {
                      print(error)
                    }
                    
                  }) {
                    Text("Refill")
                      .padding(8)
                      .background(Color("SpaceCadet"))
                      .foregroundColor(.white)
                      .clipShape(RoundedRectangle(cornerRadius: 5))
                  }
                  .buttonStyle(PlainButtonStyle())
                  
                  
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
                }
                
                HStack {
                  Text("\(pill.usage ?? "N/A") x per dose")
                    .font(.subheadline)
                    .fontWeight(.bold)
                  
                  Spacer()
                  
                  Text(pill.morning ? "morning"  : "")
                    .foregroundColor(Color("DoseGreen"))
                    .font(.subheadline)
                    .fontWeight(.bold)
                  
                  Text(pill.noon ? "noon"  : "")
                    .foregroundColor(Color("DoseGreen"))
                    .font(.subheadline)
                    .fontWeight(.bold)
                  
                  Text(pill.night ? "night"  : "")
                    .foregroundColor(Color("DoseGreen"))
                    .font(.subheadline)
                    .fontWeight(.bold)
                  
                  Spacer()
                }
                
                HStack {
                  
                  Text("\(pill.pillQuantity ?? "Unkown") pills remaining")
                  
                  Spacer()
                  
                  Button(action: {
                    let quantity = Int(pill.pillQuantity!)
                    let minus = String(quantity! - 1)
                    
                    pill.pillQuantity = minus
                    
                    hapticImpact.impactOccurred()
                    
                    do {
                      try self.managedObjectContext.save()
                    } catch {
                      print(error)
                    }
                    
                    if quantity! <= 6 {
                      self.errorShowing = true
                      self.errorTitle = "This Medication\nIs Getting Low"
                      self.errorMessage = "If needed, please get a refill soon."
                      
                      return
                    }
                    self.presentationMode.wrappedValue.dismiss()
                    
                  }) {
                    Image(systemName: "minus.circle")
                      .resizable()
                      .scaledToFit()
                      .foregroundColor(.white)
                      .background(Circle().fill(Color("ImperialRed")))
                      .frame(width: 35, height: 35)
                  } //: MINUS BUTTON
                  .buttonStyle(PlainButtonStyle())
                  Text("-")
                  Button(action: {
                    let quantity = Int(pill.pillQuantity!)
                    let add = String(quantity! + 1)
                    
                    pill.pillQuantity = add
                    
                    hapticImpact.impactOccurred()
                    
                    do {
                      try self.managedObjectContext.save()
                    } catch {
                      print(error)
                    }
                    
                  }) {
                    Image(systemName: "plus.circle")
                      .resizable()
                      .scaledToFit()
                      .foregroundColor(.white)
                      .background(Circle().fill(Color("Manatee")))
                      .frame(width: 35, height: 35)
                  } //: PLUS BUTTON
                  .buttonStyle(PlainButtonStyle())
                } //: HSTACK
              } //: VSTACK
            } //: HSTACK
          } //: FOREACH
          .onDelete(perform: deletePill)
        } //: LIST
        .navigationBarTitle("Medication")
//        .navigationBarColor(UIColor(red: 43, green: 45, blue: 66))
        .navigationBarItems(trailing: Button(action: {
          self.showingAddPillView = true
        }, label: {
          //Image(systemName: "plus").frame(width: 44, height: 44)
          HStack {
            Text("Add")
              .foregroundColor(.red)
            Image(systemName: "pills")
              .foregroundColor(.red)
          }
        }))
        if pills.count == 0 {
          Text("There Are No Medication Entries")
        }
        
        
      } //: ZSTACK
      .sheet(isPresented: $showingAddPillView) {
        AddMedicationView().environment(\.managedObjectContext, self.managedObjectContext)
      }
      .alert(isPresented: $errorShowing) {
        Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
      }
//      .overlay(
//        ZStack {
//          Group {
//            Circle()
//              .fill(Color("AmaranthRed"))
//              .opacity(0.2)
//              .frame(width: 68, height: 68, alignment: .center)
//            Circle()
//              .fill(Color("AmaranthRed"))
//              .opacity(0.15)
//              .frame(width: 88, height: 88, alignment: .center)
//          } //: GROUP
//
//          Button(action: {
//            self.showingAddPillView.toggle()
//          }) {
//            ZStack {
//              Image(systemName: "pills.fill")
//                .resizable()
//                .scaledToFit()
//                .foregroundColor(Color("AmaranthRed"))
//                .background(Circle().fill(Color("AmaranthRed")).opacity(0.1))
//                .frame(width: 48, height: 48, alignment: .center)
//
//              Image(systemName: "plus")
//                .resizable()
//                .scaledToFit()
//                .foregroundColor(.white)
//                .frame(width: 30, height: 30, alignment: .center)
//            }
//
//          }
//        } //: ZSTACK
//        .padding(.bottom, 15)
//        .padding(.trailing, 15)
//        , alignment: .bottomTrailing
//      ) //: OVERLAY
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
  
  // MARK: - FUNCTIONS
//  private func refill(at offsets: IndexSet) {
//    for index in offsets {
//      let pill = pills[index]
//      let quantity = Int(pill.pillQuantity!)
//      let refill = String(quantity! + 30)
//      
//      pill.pillQuantity = refill
//      
//      do {
//        try self.managedObjectContext.save()
//      } catch {
//        print(error)
//      }
//    }
//  }
  
}

// MARK: - PREVIEW
struct MedicationView_Previews: PreviewProvider {
  static var previews: some View {
    MedicationView()
  }
}
