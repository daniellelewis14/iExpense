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
    
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(expenses.items) { item in
                        //did not have to add id: in ForEach due to Identifiable protocol in ExpenseItems
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            
                            if item.amount >= 100 {
                                Text(item.amount, format: .currency(code: "USD"))
                                    .foregroundColor(.red)
                            } else if item.amount < 100 && item.amount > 10 {
                                Text(item.amount, format: .currency(code: "USD"))
                                    .foregroundColor(.blue)
                            } else if  item.amount <= 10 {
                                Text(item.amount, format: .currency(code: "USD"))
                                    .foregroundColor(.green)
                            }
                            
                        }
                        
                    }
                    .onDelete(perform: removeItems)
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
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
