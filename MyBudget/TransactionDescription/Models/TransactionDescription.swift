//
//  TransactionDescription.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 16.07.23.
//

import Foundation

enum TransactionCategory: String, CaseIterable {
    case trasport = "transport"
    case food = "food"
    case car = "car"
    case sallary = "sallary"
    
  static func getExpemdetureCategories() -> [TransactionCategory]{
        
        return [.trasport, .food, .car]
    }
    
 static func getIncomeCategories() -> [TransactionCategory]{
          
     return [.sallary]
      }
}

struct TransactionDescription {
    let id: String
    let bankAccountId: String
    let value: String
    let type: TransactionType
    let category: TransactionCategory
}
