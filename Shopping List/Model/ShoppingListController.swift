//
//  ShoppingListController.swift
//  Shopping List
//
//  Created by patelpra on 12/14/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class ShoppingListController {
    
    init() {
        if self.shoppingItemsPreference == false {
            self.setShoppingItems()
        } else {
            self.loadFromPersistentStore()
        }
    }
    
    // MARK: - Variables
    
    private (set) var shoppingItems: [ShoppingItem] = []
    let shoppingPreferenceKey = "shoppingPreferenceKey"
    
    var shoppingItemsAdded: [ShoppingItem] {
        return self.shoppingItems.filter { $0.hasBeenAdded == true }
    }
    
    var shoppingItemNotAdded: [ShoppingItem] {
        return self.shoppingItems.filter { $0.hasBeenAdded == false }
    }
    
    var shoppingItemsPreference: Bool? {
        return UserDefaults.standard.bool(forKey: shoppingPreferenceKey)
    }
    
    private var shoppingFileURL: URL? {
        let filemanager = FileManager.default
        guard let documentsDirectory = filemanager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documentsDirectory.appendingPathComponent("shopping.plist")
    }
    
    // MARK: - CRUD Methods
    
    func createShoppingItem(withName name: String) {
        let shoppingItem = ShoppingItem(withName: name)
        shoppingItems.append(shoppingItem)
        self.saveToPersistentStore()
    }
    
    func updateHasBeenAdded(for item: ShoppingItem) {
        guard let index = shoppingItems.firstIndex(of: item) else { return }
        shoppingItems[index].hasBeenAdded = !shoppingItems[index].hasBeenAdded
        self.saveToPersistentStore()
    }
    
    func setShoppingItems() {
        let itemNames = ["Apple", "Grapes", "Milk", "Muffin", "Popcorn", "Soda", "Strawberries"]
        for name in itemNames {
            self.createShoppingItem(withName: name)
        }
        
        
    }
    
    // MARK: - Persistence
    
    func saveToPersistentStore() {
        guard let url = self.shoppingFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let shoppingItem = try encoder.encode(self.shoppingItems)
            try shoppingItem.write(to: url)
        } catch {
            print("Error saving shoppingItems: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = self.shoppingFileURL,
            fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let shoppingItem = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            self.shoppingItems = try decoder.decode([ShoppingItem].self, from: shoppingItem)
        } catch {
            print("Error loading shoppingItems: \(error)")
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
