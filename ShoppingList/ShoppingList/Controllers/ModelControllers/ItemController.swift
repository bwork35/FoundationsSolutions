//
//  ItemController.swift
//  ShoppingList
//
//  Created by Bryan Workman on 3/29/22.
//

import Foundation

class ItemController {
    
    static let shared = ItemController()
    
    var items: [Item] = []
    
    //MARK: - CRUD
    func createItemWith(name: String) {
        let newItem = Item(name: name)
        items.append(newItem)
        saveToPersistenceStore()
    }
    
    func update(_ item: Item, name: String) {
        item.name = name
        saveToPersistenceStore()
    }
    
    func toggleDidPurchaseFor(_ item: Item) {
        item.didPurchase.toggle()
        saveToPersistenceStore()
    }
    
    func delete(_ item: Item) {
        guard let index = items.firstIndex(of: item) else { return }
        items.remove(at: index)
        saveToPersistenceStore()
    }
    
    //MARK: - Persistence
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("ShoppingList.json")
        return fileURL
    }
    
    //Save
    func saveToPersistenceStore() {
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(items)
            try data.write(to: createPersistenceStore())
        } catch {
            print("Error encoding data --- \(error) --- \(error.localizedDescription)")
        }
    }
    
    //Load
    func loadFromPersistenceStore() {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            items = try jsonDecoder.decode([Item].self, from: data)
        } catch {
            print("Error decoding our data --- \(error) --- \(error.localizedDescription)")
        }
    }
    
} //End of class
