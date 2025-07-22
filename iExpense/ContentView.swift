//
//  ContentView.swift
//  iExpense
//
//  Created by Sandro Gakharia on 22.07.25.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
    
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("Personal") {
                    let personalItems = expenses.items.enumerated().filter { $0.element.type == "Personal" }
                    ForEach(personalItems, id: \.element.id) { index, item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundStyle(item.amount <= 10 ? .green : item.amount <= 100 ? .orange : .red)
                        }
                    }
                    .onDelete { offsets in
                        let indicesToDelete = offsets.map { personalItems[$0].offset }
                        expenses.items.remove(atOffsets: IndexSet(indicesToDelete))
                    }
                }
                
                Section("Business") {
                    let businessItems = expenses.items.enumerated().filter { $0.element.type == "Business" }
                    ForEach(businessItems, id: \.element.id) { index, item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundStyle(item.amount <= 10 ? .green : item.amount <= 100 ? .orange : .red)
                        }
                    }
                    .onDelete { offsets in
                        let indicesToDelete = offsets.map { businessItems[$0].offset }
                        expenses.items.remove(atOffsets: IndexSet(indicesToDelete))
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
}

#Preview {
    ContentView()
}
