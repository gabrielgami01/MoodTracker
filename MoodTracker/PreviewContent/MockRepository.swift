//
//  MockRepository.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 9/5/25.
//

import Foundation
import CoreData

struct MockRepository: Repository {
    let persistenceController = PersistenceController(inMemory: false)
}
