//
//  TabBarView.swift
//  Rehab
//
//  Created by Joshua Basche on 3/14/21.
//

import SwiftUI
import MessageUI
import CoreData

struct TabBarView: View {
  // MARK: - PROPERTIES
  //  private let messageComposeDelegate = MessageComposerDelegate()
  @Environment(\.managedObjectContext) var managedObjectContext
  
  var phoneNumber = "310-806-7483"
  
  //  @FetchRequest(entity: Bell.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Bell.phoneNumber, ascending: false)]) var bells: FetchedResults<Bell>
  
  //  @ObservedObject var bell: Bell
  
  @State private var showingBellSettingsView: Bool = false
  
  //  init(id objectID: NSManagedObjectID, in context: NSManagedObjectContext) {
  //    if let bell = try? context.existingObject(with: objectID) as? Bell {
  //      self.bell = bell
  //    } else {
  //      self.bell = Bell(context: context)
  //      try? context.save()
  //    }
  //  }
  
  init() {
    UITabBar.appearance().barTintColor = UIColor(red: 43, green: 45, blue: 66)
  }
  
  // MARK: - BODY
  var body: some View {
    NavigationView {
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
      }
      .accentColor(Color("AliceBlue"))
      .font(.headline)
      .navigationBarTitle("Rehab", displayMode: .inline)
      .navigationBarColor(UIColor(red: 43, green: 45, blue: 66))
      .navigationBarItems(
        leading:
          Button(action: {
            let phone = "tel://"
            let phoneNumberformatted = phone + phoneNumber
            guard let url = URL(string: phoneNumberformatted) else { return }
            UIApplication.shared.open(url)
            //            sendMessage()
          }, label: {
            HStack(spacing: 2) {
              Image(systemName: "phone.fill")
                .foregroundColor(Color("ImperialRed"))
                .font(.title)
              Text("Help")
                .foregroundColor(Color("ImperialRed"))
                .font(.title2)
                .fontWeight(.bold)
            }
          })
        //        trailing:
        //          Button(action: {
        //            self.showingBellSettingsView.toggle()
        //          }, label: {
        //            Image(systemName: "gearshape.fill").frame(width: 44, height: 44)
        //              .foregroundColor(.blue)
        //          })
        
      )
    } //: TABVIEW
    .sheet(isPresented: $showingBellSettingsView) {
      BellSettingsView().environment(\.managedObjectContext, self.managedObjectContext)
    }
  } //: NAVIGATION
  
  func sendMessage(){
    let sms: String = "sms:+13108067483&body=Ring! Ring! I need your help!"
    let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
  }
}


// MARK: - PREVIEW
struct TabBarView_Previews: PreviewProvider {
  static var previews: some View {
    TabBarView()
  }
}
