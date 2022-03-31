//
//  Event+Convenience.swift
//  EventManager
//
//  Created by Bryan Workman on 3/29/22.
//

import CoreData

extension Event {
    
    @discardableResult
    convenience init(title: String, date: Date, isAttending: Bool = true, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.title = title
        self.date = date
        self.isAttending = isAttending
    }
    
} //End of extension
