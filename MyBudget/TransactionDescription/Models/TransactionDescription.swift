//
//  TransactionDescription.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 16.07.23.
//

import Foundation

enum TransactionCategory {
    case trasport
    case food
    case car
}

struct TransactionDescription {
    let id: String
    let bankAccountId: String
    let value: String
    let type: TransactionType
    let category: TransactionCategory
}
