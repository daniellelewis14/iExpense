//
//  ContentView.swift
//  iExpense
//
//  Created by Danielle Lewis on 7/14/23.
//

import SwiftUI


struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    func removeItems(at offsets: IndexSet, in inputArray: [ExpenseItem]) {
        var objectsToDelete = IndexSet()
        
        for offset in offsets {
            let item = inputArray[offset]
            
            if let index = expenses.items.firstIndex(of: item) {
                objectsToDelete.insert(index)
            }
        }
        
        expenses.items.remove(atOffsets: offsets)
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.personalItems)
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.businessItems)
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ExpenseSection(title: "Business", expenses: expenses.businessItems, deleteItems: removeBusinessItems)
                    ExpenseSection(title: "Personal", expenses: expenses.personalItems, deleteItems: removePersonalItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
       
        
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension FormatStyle where Self == FloatingPointFormatStyle<Double>.Currency {
    static var localCurrency: Self {
        .currency(code: Locale.current.currency?.identifier ?? "USD")
    }
}
