//
//  SelectedCalendarsList.swift
//  Rehab
//
//  Created by Joshua Basche on 3/17/21.
//


import SwiftUI
import EventKit

struct SelectedCalendarsList: View {
    let selectedCalendars: [EKCalendar]
    
    var joinedText: Text {
        var text = Text("")
        
        for calendar in selectedCalendars {
            text = text + calendar.formattedText + Text("  ")
        }
        
        return text
    }
    
    var body: some View {
        joinedText.foregroundColor(.secondary)
    }
}
