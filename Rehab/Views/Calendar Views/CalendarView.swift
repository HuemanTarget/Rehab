//
//  CalendarView.swift
//  Rehab
//
//  Created by Joshua Basche on 3/14/21.
//

import SwiftUI
import EventKit
import Combine

struct CalendarView: View {
  //  enum ActiveSheet {
  //    case calendarChooser
  //    case calendarEdit
  //  }
  
  enum ActiveSheet: Identifiable {
    case calendarChooser, calendarEdit
    
    var id: Int {
      hashValue
    }
  }
  
  @State private var showingSheet = false
  @State private var activeSheet: ActiveSheet?
  //  @State private var activeSheet: ActiveSheet?
  
  @ObservedObject var eventsRepository = EventsRepository.shared
  
  @State private var selectedEvent: EKEvent?
  
  func showEditFor(_ event: EKEvent) {
    activeSheet = .calendarEdit
    selectedEvent = event
    showingSheet = true
  }
  
//  init() {
//    UINavigationBar.appearance().backgroundColor = .lairBackgroundGray
//  }
  
  
  var body: some View {
    NavigationView {
      ZStack {
        Color(.lairBackgroundGray)
          .edgesIgnoringSafeArea(.all)
        VStack {
          List {
            if eventsRepository.events?.isEmpty ?? true {
              Text("No upcoming events")
            }
            
            ForEach(eventsRepository.events ?? [], id: \.self) { event in
              EventRow(event: event).onTapGesture {
                self.showEditFor(event)
              }
            }
          }.listStyle(PlainListStyle())
          
          
          
          
          
          SelectedCalendarsList(selectedCalendars: Array(eventsRepository.selectedCalendars ?? []))
            .padding(.vertical)
            .padding(.horizontal, 5)
          
          
          Button(action: {
            self.activeSheet = .calendarChooser
            self.showingSheet = true
          }) {
            Text("Select Calendars")
              .foregroundColor(.black)
          }
          
          .softButtonStyle(RoundedRectangle(cornerRadius: 20))
          //        .buttonStyle(PrimaryButtonStyle())
          //        .font(.system(size: 14, weight: .bold, design: .default))
          //        .frame(width: 150, height: 50)
          //        .background(Color.blue)
          //        .cornerRadius(9)
          //        .foregroundColor(.white)
          .padding(.bottom, 20)
          
          
          
          
          
          
          
          //          .sheet(isPresented: $showingSheet) {
          //            if self.activeSheet == .calendarChooser {
          //              CalendarChooser(calendars: self.$eventsRepository.selectedCalendars, eventStore: self.eventsRepository.eventStore)
          //            } else {
          //              EventEditView(eventStore: self.eventsRepository.eventStore, event: self.selectedEvent)
          //            }
          //          }
          .sheet(item: $activeSheet) { item in
            switch item {
            case .calendarChooser:
              CalendarChooser(calendars: self.$eventsRepository.selectedCalendars, eventStore: self.eventsRepository.eventStore)
            case .calendarEdit:
              EventEditView(eventStore: self.eventsRepository.eventStore, event: self.selectedEvent)
            }
            
          }
          
          
        }
        
        
        
        .navigationBarTitle("Calendar")
        //      .navigationBarColor(UIColor(red: 43, green: 45, blue: 66))
        //        .navigationBarItems(trailing: Button(action: {
        //          self.selectedEvent = nil
        //          self.activeSheet = .calendarEdit
        //          self.showingSheet = true
        //        }, label: {
        //          //Image(systemName: "plus").frame(width: 44, height: 44)
        //          HStack {
        //            Text("Add")
        //              .foregroundColor(.red)
        //            Image(systemName: "calendar")
        //              .foregroundColor(.red)
        //          }
        //      }))
        .navigationBarItems(trailing:
                              HStack {
                                Button(action: {
                                  self.selectedEvent = nil
                                  self.activeSheet = .calendarEdit
                                  self.showingSheet = true
                                }) {
                                  HStack {
                                    Text("Add")
                                      .foregroundColor(.black)
                                    Image(systemName: "calendar")
                                      .foregroundColor(.black)
                                  }
                                }
                                .softButtonStyle(RoundedRectangle(cornerRadius: 20))
                              }
        )
      }
      
    }
    
  }
}

// MARK: - PREVIEW
struct CalendarView_Previews: PreviewProvider {
  static var previews: some View {
    CalendarView()
  }
}
