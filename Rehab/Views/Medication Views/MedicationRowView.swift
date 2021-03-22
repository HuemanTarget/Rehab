//
//  MedicationRowView.swift
//  Rehab
//
//  Created by Joshua Basche on 3/22/21.
//

import SwiftUI

struct MedicationRowView: View {
  // MARK: - PROPERTIES
  @FetchRequest(entity: Pill.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Pill.name, ascending: true)]) var pills: FetchedResults<Pill>
  
  // MARK: - BODY
  var body: some View {
    ZStack {
      List {
        
      }
    }
  }
}

// MARK: - PREVIEW
struct MedicationRowView_Previews: PreviewProvider {
  static var previews: some View {
    MedicationRowView()
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
