//
//  EventController.swift
//  EventManager
//
//  Created by Bryan Workman on 3/29/22.
//

import CoreData

class EventController {
    
    static let shared = EventController()
    
    var events: [Event] = []
    
    private lazy var fetchRequest: NSFetchRequest<Event> = {
        let fetchRequest = NSFetchRequest<Event>(entityName: "Event")
        fetchRequest.predicate = NSPredicate(value: true)
        return fetchRequest
    }()
    
    //MARK: - CRUD
    func createEventWith(title: String, date: Date) {
        let newEvent = Event(title: title, date: date)
        events.append(newEvent)
        CoreDataStack.saveContext()
    }
    
    func fetchAllEvents() {
        let fetchedEvents = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        self.events = fetchedEvents
    }
    
    func update(_ event: Event, title: String, date: Date) {
        event.title = title
        event.date = date
        CoreDataStack.saveContext()
    }
    
    func toggleIsAttendingFor(_ event: Event) {
        event.isAttending.toggle()
        CoreDataStack.saveContext()
    }
    
    func delete(_ event: Event) {
        guard let index = events.firstIndex(of: event) else { return }
        events.remove(at: index)
        CoreDataStack.context.delete(event)
        CoreDataStack.saveContext()
    }
    
} //End of class

