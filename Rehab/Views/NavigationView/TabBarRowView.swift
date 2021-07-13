//
//  TabBarRowView.swift
//  Rehab
//
//  Created by Joshua Basche on 5/27/21.
//

import SwiftUI

struct TabBarRowView: View {
  @Binding var selectedItem: SmartView

  var tabBarItems: [TabBarItemView]
  let size: CGFloat = 32
  
  var body: some View {
    HStack {
      ForEach(tabBarItems, id: \.uuid) { item in
        VStack {
          HStack {
            Spacer()

            item  

            Spacer()
          }
          Text(item.title)
            .bold()
            .font(.subheadline)
        }
      }
    }
    .padding(.top, 11)
    .padding(.bottom, 22)
    
  }
}

struct TabBarRowView_Previews: PreviewProvider {
  static var previews: some View {
    TabBarRowView(
      selectedItem: .constant(.calendar),
      tabBarItems: [
        TabBarItemView(
          selectedItem: .constant(.calendar),
          smartView: .calendar,
          icon: "calendar",
          title: "Calendar"
          ),
        TabBarItemView(
          selectedItem: .constant(.calendar),
          smartView: .medication,
          icon: "pills",
          title: "Medication"
        ),
        TabBarItemView(
          selectedItem: .constant(.calendar),
          smartView: .journal,
          icon: "book.closed",
          title: "Journal"
          )
      ]
    )
  }
}
