//
//  ExpenseSection.swift
//  iExpense
//
//  Created by Danielle Lewis on 7/16/23.
//

import SwiftUI

struct ExpenseSection: View {
    let title: String
    let expenses: [ExpenseItem]
    let deleteItems: (IndexSet) -> Void

    var body: some View {
        Section(title) {
            ForEach(expenses) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.type)
                    }

                    Spacer()

                    if item.amount >= 100 {
                        Text(item.amount, format: .localCurrency)
                            .foregroundColor(.red)
                    } else if item.amount < 100 && item.amount > 10 {
                        Text(item.amount, format: .localCurrency)
                            .foregroundColor(.blue)
                    } else if item.amount <= 10 {
                        Text(item.amount, format: .localCurrency)
                            .foregroundColor(.green)
                    }
                    
                        
                }
            }
            .onDelete(perform: deleteItems)
        }
    }
}

//struct ExpenseSection_Previews: PreviewProvider {
//    static var previews: some View {
//        ExpenseSection()
//    }
//}
