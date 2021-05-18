//
//  CoreDataManager.swift
//  Rehab
//
//  Created by Joshua Basche on 5/17/21.
//

import Foundation
import CoreData
import SwiftUI

class CoreDataManager {
  
  let persistentContainer: NSPersistentContainer
  
  static let shared = CoreDataManager()
  
  private init() {
    
    persistentContainer = NSPersistentContainer(name: "Rehab")
    persistentContainer.loadPersistentStores {
      (description, error) in
      
      if let error = error {
        fatalError("Failed to initialize Core Data \(error)")
      }
    }
    
    let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    print(directories[0])
    
  }
  
}
