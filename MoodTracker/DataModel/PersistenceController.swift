//
//  PersistenceController.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 9/5/25.
//

import Foundation
import CoreData

final class PersistenceController {
    static let shared = PersistenceController()
    
    let persistentContainer: NSPersistentContainer
    
    init(inMemory: Bool = true) {
        persistentContainer = NSPersistentContainer(name: "MoodDataModel")
        
        if !inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                fatalError("Error loading persistent stores: \(error)")
            }
        }
        
        persistentContainer.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func newBackgroundContext() -> NSManagedObjectContext {
        persistentContainer.newBackgroundContext()
    }
}
