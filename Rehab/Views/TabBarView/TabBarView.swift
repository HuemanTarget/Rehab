//
//  TabBarView.swift
//  Rehab
//
//  Created by Joshua Basche on 3/14/21.
//

import SwiftUI
import MessageUI

struct TabBarView: View {
  // MARK: - PROPERTIES
//  private let messageComposeDelegate = MessageComposerDelegate()
  @Environment(\.managedObjectContext) var managedObjectContext
  
  @FetchRequest(entity: Bell.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Bell.phoneNumber, ascending: false)]) var bells: FetchedResults<Bell>
  
  @State private var showingBellSettingsView: Bool = false
  
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
      .navigationBarTitle("Rehab", displayMode: .inline)
      .navigationBarItems(leading: Button(action: {
        sendMessage()
      }, label: {
        HStack(spacing: 2) {
          Image(systemName: "bell.fill").frame(width: 44, height: 44)
            .foregroundColor(.red)
          Text("Help")
            .foregroundColor(.red)
        }
      }))
      .navigationBarItems(trailing: Button(action: {
        sendMessage()
      }, label: {
        HStack(spacing: 2) {
          Image(systemName: "bell.fill").frame(width: 44, height: 44)
            .foregroundColor(.red)
          Text("Help")
            .foregroundColor(.red)
        }
      }))
    } //: TABVIEW
    .sheet(isPresented: $showingBellSettingsView) {
      BellSettingsView().environment(\.managedObjectContext, self.managedObjectContext)
    }
  } //: NAVIGATION
  
  func sendMessage(){
    let sms: String = "sms:+15627610792&body=Full vacinated people now get free Krispy Kreme Donuts. Reply to find out more information."
    let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
  }
}

//extension TabBarView {
//  private class MessageComposerDelegate: NSObject, MFMessageComposeViewControllerDelegate {
//    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
//      // Customize here
//      controller.dismiss(animated: true)
//    }
//  }
//  /// Present an message compose view controller modally in UIKit environment
//  private func presentMessageCompose() {
//    guard MFMessageComposeViewController.canSendText() else {
//      return
//    }
//    let vc = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
//    let composeVC = MFMessageComposeViewController()
//    composeVC.messageComposeDelegate = messageComposeDelegate
//
//    vc?.present(composeVC, animated: true)
//  }
//}

// MARK: - PREVIEW
struct TabBarView_Previews: PreviewProvider {
  static var previews: some View {
    TabBarView()
  }
}
