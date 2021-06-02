//
//  JournalView.swift
//  Rehab
//
//  Created by Joshua Basche on 3/14/21.
//

import SwiftUI

struct JournalView: View {
  // MARK: - PROPERTIES
  @Environment(\.managedObjectContext) var managedObjectContext
  
  @FetchRequest(entity: Journal.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Journal.date, ascending: false)]) var journals: FetchedResults<Journal>
  
  @State private var showingAddJournalView: Bool = false
  
  var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .short
    return formatter
  }
  
//  init() {
//    UINavigationBar.appearance().largeTitleTextAttributes =
//      [.foregroundColor: UIColor.lairDarkGray]
//  }
  
  
  // MARK: - BODY
  var body: some View {
    NavigationView {
      ZStack {
        Color.lairBackgroundGray
        List {
          if journals.count == 0 {
            Text("There Are No Journal Entries")
          }
          
          ForEach(self.journals, id: \.self) { journal in
            VStack(alignment: .leading) {
              Text("\(journal.date ?? Date(), formatter: self.dateFormatter)")
                .padding(.bottom, 2)
                .font(.subheadline)
              
              Text(journal.desc ?? "Unkown")
                .padding(.bottom, 2)
                .font(.title)
              HStack {
                Text("HR: \(journal.hr!)" )
                
                Spacer()
                
                Text("BP: \(journal.bp ?? "N/A") / \(journal.bpd ?? "N/A")")
                
                Spacer()
                
                Text("Pain Level: \(journal.pain!)")
              }
              .padding(.bottom, 2)
              .font(.subheadline)
              
              HStack {
                Text("Temp: \(journal.temperature ?? "N/A") \(journal.tempType ?? "N/A")")
                
                Spacer()
                
                Text("Oxygen: \(journal.oxygen ?? "N/A")%")
                
                Spacer()
              }
              
              .padding(.bottom, 2)
              .font(.subheadline)
              
              Text("Notes: \(journal.notes!)")
                .padding(.bottom, 2)
              
            }
          } //: FOREACH
          .onDelete(perform: deleteJournal)
//          .background(Color.green)
        } //: LIST
        
        .navigationBarTitle("Journal")
//        .navigationBarColor(UIColor(red: 43, green: 45, blue: 66))
        .navigationBarItems(trailing: Button(action: {
          self.showingAddJournalView = true
        }, label: {
          //Image(systemName: "plus").frame(width: 44, height: 44)
          HStack {
            Text("Add")
              .foregroundColor(.red)
            Image(systemName: "calendar")
              .foregroundColor(.red)
          }
        }))
//        if journals.count == 0 {
//          Text("There Are No Journal Entries")
//        }
        
        
      } //: ZSTACK
      
      .sheet(isPresented: $showingAddJournalView) {
        AddJournalView().environment(\.managedObjectContext, self.managedObjectContext)
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
//            self.showingAddJournalView.toggle()
//          }) {
//            ZStack {
//              Image(systemName: "book.closed.fill")
//                .resizable()
//                .scaledToFit()
//                .foregroundColor(Color("AmaranthRed"))
//                .background(Circle().fill(Color("AmaranthRed")).opacity(0.3))
//                .frame(width: 48, height: 48, alignment: .center)
//              
//              Image(systemName: "plus")
//                .resizable()
//                .scaledToFit()
//                .foregroundColor(.white)
//                .frame(width: 30, height: 30, alignment: .center)
//            }
//          }
//        } //: ZSTACK
//        .padding(.bottom, 15)
//        .padding(.trailing, 15)
//        , alignment: .bottomTrailing
//      ) //: OVERLAY
    } //: NAVIGATION
  }
  
  // MARK: - FUNCTIONS
  
  private func deleteJournal(at offsets: IndexSet) {
    for index in offsets {
      let journal = journals[index]
      managedObjectContext.delete(journal)
      
      do {
        try managedObjectContext.save()
      } catch {
        print(error)
      }
    }
  }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}

// MARK: - PREVIEW
struct JournalView_Previews: PreviewProvider {
  static var previews: some View {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    return JournalView()
      .environment(\.managedObjectContext, context)
    
  }
}
