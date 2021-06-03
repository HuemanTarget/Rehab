//
//  TimeIntervalExtension.swift
//  Rehab
//
//  Created by Joshua Basche on 3/16/21.
//

import Foundation


extension TimeInterval {
  static func weeks(_ weeks: Double) -> TimeInterval {
    return weeks * TimeInterval.week
  }
  
  static func months(_ months: Double) -> TimeInterval {
    return months * TimeInterval.month
  }
  
  static var week: TimeInterval {
    return 7 * 24 * 60 * 60
  }
  
  static var month: TimeInterval {
    return 30 * 24 * 60 * 60
  }
}
