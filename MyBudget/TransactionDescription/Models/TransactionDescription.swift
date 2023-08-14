//
//  TransactionDescription.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 16.07.23.
//

import Foundation

struct TransactionDescription {
    let id: String
    let bankAccountId: String
    let value: String
    let type: TransactionType
    let categoryId: String
    let date: Date
}
