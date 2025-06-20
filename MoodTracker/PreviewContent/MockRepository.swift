//
//  MockRepository.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 9/5/25.
//

import Foundation
import CoreData

struct MockRepository: Repository {
    let persistenceController = PersistenceController(forPreview: true)
}

extension PersistenceController {
    func loadMockData(context: NSManagedObjectContext) {
        for mood in Mood.mocks {
            let newMoodEntity = MoodEntity(context: context)
            newMoodEntity.id = mood.id
            newMoodEntity.type = mood.type.rawValue
            newMoodEntity.emotions = mood.emotions.map { $0.rawValue } as NSArray
            newMoodEntity.note = mood.note
            newMoodEntity.slot = mood.timeSlot.rawValue
            newMoodEntity.date = mood.date

            let newReasonEntity = ReasonEntity(context: context)
            newReasonEntity.id = mood.reason.id
            newReasonEntity.name = mood.reason.name

            newMoodEntity.reason = newReasonEntity
        }

        try? context.save()
    }
}
