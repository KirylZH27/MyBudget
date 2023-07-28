//
//  TransactionDeleter.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 28.07.23.
//

import Foundation
protocol TransactionDeleter {
    func deleteTrnasaction(transaction: TransactionDescription, completion: @escaping (Error?) -> Void)
}
