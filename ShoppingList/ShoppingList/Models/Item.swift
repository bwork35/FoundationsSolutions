//
//  Item.swift
//  ShoppingList
//
//  Created by Bryan Workman on 3/29/22.
//

import Foundation

class Item: Codable {
    
    var name: String
    var didPurchase: Bool
    
    init(name: String, didPurchase: Bool = false) {
        self.name = name
        self.didPurchase = didPurchase
    }
    
} //End of class

extension Item: Equatable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name && lhs.didPurchase == rhs.didPurchase
    }
} //End of extension
