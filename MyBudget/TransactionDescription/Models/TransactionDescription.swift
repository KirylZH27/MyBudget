//
//  TransactionDescription.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 16.07.23.
//

import Foundation

enum TransactionCategory: String {
    case trasport = "transport"
    case food = "food"
    case car = "car"
}

struct TransactionDescription {
    let id: String
    let bankAccountId: String
    let value: String
    let type: TransactionType
    let category: TransactionCategory
}
