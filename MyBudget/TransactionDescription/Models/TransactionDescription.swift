//
//  TransactionDescription.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 16.07.23.
//

import Foundation

enum TransactionCategory2: String, CaseIterable {
    case trasport = "Транспорт"
    case food = "Еда"
    case car = "Машина"
    case sallary = "Зарплата"
    
 static func getExpemdetureCategories() -> [TransactionCategory2]{
        
        return [.trasport, .food, .car]
    }
    
 static func getIncomeCategories() -> [TransactionCategory2]{
          
     return [.sallary]
      }
}

struct TransactionDescription {
    let id: String
    let bankAccountId: String
    let value: String
    let type: TransactionType
    let category: TransactionCategory2
    let date: Date
}
