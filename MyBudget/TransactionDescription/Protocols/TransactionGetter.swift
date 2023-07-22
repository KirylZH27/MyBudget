//
//  TransactionGetter.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 16.07.23.
//

import Foundation

protocol TransactionGetter{
    func getBankAccountTransaction(by id: String, completion: @escaping ([TransactionDescription]) -> Void)
    func getAllTransactions(completion: @escaping ([TransactionDescription]) -> Void)
}
