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
  
  static var week: TimeInterval {
    return 7 * 24 * 60 * 60
  }
}
