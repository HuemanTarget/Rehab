//
//  File.swift
//  Rehab
//
//  Created by Joshua Basche on 5/28/21.
//

import Foundation
import SwiftUI
import GoogleMobileAds

struct AdView : UIViewRepresentable {
  
  func makeUIView(context: UIViewRepresentableContext<AdView>) -> GADBannerView {
    let banner = GADBannerView(adSize: kGADAdSizeBanner)
    
    banner.adUnitID = "ca-app-pub-9462406136223415/8798429994"
    banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
    banner.load(GADRequest())
    return banner
  }
  
  func updateUIView(_ uiView: GADBannerView, context: UIViewRepresentableContext<AdView>) {
    
  }
  
  
}
