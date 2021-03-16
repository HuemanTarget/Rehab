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
  
  @FetchRequest(entity: Journal.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Journal.date, ascending: true)]) var journals: FetchedResults<Journal>
  
  @State private var showingAddJournalView: Bool = false
  
  // MARK: - BODY
  var body: some View {
    NavigationView {
      ZStack {
        List {
          ForEach(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
            Text("Journal View")
          } //: FOREACH
        } //: LIST
        .navigationBarTitle("Journal", displayMode: .inline)
      } //: ZSTACK
      .sheet(isPresented: $showingAddJournalView) {
        AddJournalView().environment(\.managedObjectContext, self.managedObjectContext)
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
            self.showingAddJournalView.toggle()
          }) {
            Image(systemName: "book.closed")
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
struct JournalView_Previews: PreviewProvider {
  static var previews: some View {
    JournalView()
  }
}
