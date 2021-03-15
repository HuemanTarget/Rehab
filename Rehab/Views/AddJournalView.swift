//
//  AddJournalView.swift
//  Rehab
//
//  Created by Joshua Basche on 3/15/21.
//

import SwiftUI

struct AddJournalView: View {
  // MARK: - PROPERTIES
  @Environment(\.managedObjectContext) var managedObjectContext
  @Environment(\.presentationMode) var presentationMode
  
  @State private var date = Date()
  @State private var desc: String = ""
  
  // MARK: - BODY
  var body: some View {
    NavigationView {
      VStack(alignment: .center, spacing: 0) {
        Form {
          // Date
          Section(header: Text("Journal Date")) {
            
          }
          
          // Description
          Section(header: Text("Journal Description")) {
            TextField("Description", text: $desc)
              .padding(10)
              .cornerRadius(9)
              .font(.system(size: 24, weight: .bold, design: .default))
          }
        }
      }
    }
  }
}

// MARK: - PREVIEW
struct AddJournalView_Previews: PreviewProvider {
  static var previews: some View {
    AddJournalView()
  }
}
