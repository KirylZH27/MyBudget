//
//  TransactionDescriptionViewModel.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 16.07.23.
//

import Foundation
import Combine
final class TransactionDescriptionViewModel {
    
    private let bankAccountGetter: BankAccountGetter
    private let transactionCreator: TransactionCreator
    private (set) var transactionWasCreated = PassthroughSubject<Bool,Never>()
    
    init(bankAccountGetter: BankAccountGetter, transactionCreator: TransactionCreator) {
        self.bankAccountGetter = bankAccountGetter
        self.transactionCreator = transactionCreator
    }
    
    func createTransaction(transaction: TransactionDescription){
        transactionCreator.createTransaction(transaction: transaction) { [weak self] _ in
            self?.transactionWasCreated.send(true)
        }
    }
    
}
