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
  
  var viewContext: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  func getJournalById(id: NSManagedObjectID) -> Journal? {
    
    do {
      return try persistentContainer.viewContext.existingObject(with: id) as? Journal
    } catch {
      print(error)
      return nil
    }
  }
  
  func getAllJournals() -> [Journal] {
    
    let fetchRequest: NSFetchRequest<Journal> = Journal.fetchRequest()
    
    do {
      return try persistentContainer.viewContext.fetch(fetchRequest)
    } catch {
      return []
    }
  }
  
  func getPillById(id: NSManagedObjectID) -> Pill? {
    
    do {
      return try persistentContainer.viewContext.existingObject(with: id) as? Pill
    } catch {
      print(error)
      return nil
    }
  }
  
  func getAllPills() -> [Pill] {
    
    let fetchRequest: NSFetchRequest<Pill> = Pill.fetchRequest()
    
    do {
      return try persistentContainer.viewContext.fetch(fetchRequest)
    } catch {
      return []
    }
  }
  
  func save() {
    do {
      try persistentContainer.viewContext.save()
    } catch {
      persistentContainer.viewContext.rollback()
      print("Failed to save \(error)")
    }
  }
  
}
