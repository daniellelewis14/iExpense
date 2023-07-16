//
//  Expenses.swift
//  iExpense
//
//  Created by Danielle Lewis on 7/15/23.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            // Encodes data once added to Expense Item array
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    // loads saved UserData when opening the app
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
    
    var personalItems: [ExpenseItem] {
        items.filter { $0.type == "Personal" }
    }

    var businessItems: [ExpenseItem] {
        items.filter { $0.type == "Business" }
    }
    
}
