//
//  TransactionCreator.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 16.07.23.
//

import Foundation

protocol TransactionCreator {
    func createTransaction(transaction: TransactionDescription, completion: @escaping () -> Void)
}


