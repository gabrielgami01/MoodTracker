//
//  ReasonEntity.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 9/5/25.
//

import Foundation
import CoreData

extension ReasonEntity {
    var toReason: Reason? {
        guard let id, let name else { return nil }
        
        return Reason(id: id, name: name)
    }
}
