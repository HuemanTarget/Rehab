//
//  TabBarView.swift
//  Rehab
//
//  Created by Joshua Basche on 3/14/21.
//

import SwiftUI
import MessageUI
import CoreData

enum SmartView {
  case calendar
  case medication
  case journal
}

struct TabBarView: View {
  // MARK: - PROPERTIES
  @Environment(\.managedObjectContext) var managedObjectContext
  @State var selectedItem = SmartView.calendar
  var phoneNumber = "310-806-7483"
  
  init() {
    UITableView.appearance().separatorStyle = .none
//    UITableView.appearance().backgroundColor = .clear
//    UITableViewCell.appearance().backgroundColor = UIColor(Color.red)
    UINavigationBar.appearance().backgroundColor = .clear
    UITableView.appearance().backgroundColor = UIColor(Color.lairBackgroundGray)
  }
  
  // MARK: - BODY
  var body: some View {
    GeometryReader { geometry in
      VStack(spacing: 0) {
        ZStack {
          if self.selectedItem == .calendar {
            CalendarView()
            MedicationView().hidden()
            JournalView().hidden()
          } else if self.selectedItem == .medication {
            CalendarView().hidden()
            MedicationView()
            JournalView().hidden()
          } else if self.selectedItem == .journal {
            CalendarView().hidden()
            MedicationView().hidden()
            JournalView()
          }
        }
        
        
        TabBarRowView(
          selectedItem: self.$selectedItem,
          tabBarItems: [
            TabBarItemView(
              selectedItem: self.$selectedItem,
              smartView: .calendar, icon: "calendar"),
            TabBarItemView(
              selectedItem: self.$selectedItem,
              smartView: .medication, icon: "pills"),
            TabBarItemView(
              selectedItem: self.$selectedItem,
              smartView: .journal, icon: "book.closed")
          ])
          //          .padding(.bottom)
          .background(Color.lairBackgroundGray)
      }
      .edgesIgnoringSafeArea(.bottom)
    }
    
    //    func sendMessage(){
    //      let sms: String = "sms:+13108067483&body=Ring! Ring! I need your help!"
    //      let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    //      UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
    //    }
  }
}


// MARK: - PREVIEW
struct TabBarView_Previews: PreviewProvider {
  static var previews: some View {
    TabBarView()
  }
}
