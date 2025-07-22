# iExpense

A simple and intuitive iOS expense tracker built with SwiftUI.  
Track your personal and business expenses separately, see amounts color-coded by size, and easily add or delete entries.

## Features

- Add expenses with name, type (Personal or Business), and amount
- Expenses split into two sections: Personal and Business
- Color-coded amounts:
  - Green for small expenses (≤ $10)
  - Orange for medium expenses (≤ $100)
  - Red for large expenses (> $100)
- Swipe to delete expenses from either section
- Persistent storage with UserDefaults using Codable

## Code Overview

- `ExpenseItem`: Represents an expense with name, type, and amount  
- `Expenses`: Observable class storing and persisting the expense list  
- `ContentView`: Displays the expenses in two sections with add/delete support  
