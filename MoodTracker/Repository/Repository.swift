//
//  Repository.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 9/5/25.
//

import Foundation
import CoreData

protocol Repository {
    var persistenceController: PersistenceController { get }
}

extension Repository {
    func fetchMoods(date: Date = .now) throws -> [Mood] {
        let context = persistenceController.viewContext
        
        let request = MoodEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \MoodEntity.date, ascending: false)]
        
        let results = try context.fetch(request).compactMap(\.toMood)
        return results
    }
    
    func fetchReasons() throws -> [Reason] {
        let context = persistenceController.viewContext
        
        let request = ReasonEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \ReasonEntity.name, ascending: false)]
        
        let results = try context.fetch(request).compactMap(\.toReason)
        return results
    }
    
    func addMood(_ mood: Mood) throws {
        let context = persistenceController.viewContext
        
        guard let reasonEntity = try fetchReason(withID: mood.reason.id) else { return }
        
        let newMoodEntity = MoodEntity(context: context)
        newMoodEntity.id = mood.id
        newMoodEntity.type = mood.type.rawValue
        newMoodEntity.emotions = mood.emotions.map(\.rawValue) as NSArray
        newMoodEntity.reason = reasonEntity
        newMoodEntity.note = mood.note
        newMoodEntity.date = Date.now
    }
    
    func addReason(_ reason: Reason) throws {
        let context = persistenceController.viewContext
        
        let newReasonEntity = ReasonEntity(context: context)
        newReasonEntity.id = reason.id
        newReasonEntity.name = reason.name
        
        try context.save()
    }
    
    private func fetchReason(withID id: UUID) throws -> ReasonEntity? {
        let context = persistenceController.viewContext
        
        let request = ReasonEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        guard let result = try context.fetch(request).first else { return nil }
        return result
    }
    
    func preloadDefaultReasons() async throws {
        let context = persistenceController.newBackgroundContext()
        
        guard let url = Bundle.main.url(forResource: "defaultReasons", withExtension: "json") else { return }
        let data = try Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        
        let reasons = try decoder.decode([Reason].self, from: data)
        
        try await context.perform {
            for reason in reasons {
                let newReasonEntity = ReasonEntity(context: context)
                newReasonEntity.id = reason.id
                newReasonEntity.name = reason.name
            }
            try context.save()
        }
    }
}

struct RepositoryImpl: Repository {
    static let shared = RepositoryImpl()
    
    let persistenceController = PersistenceController.shared
}
