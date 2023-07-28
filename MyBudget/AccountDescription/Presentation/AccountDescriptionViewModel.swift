//
//  AccountDescriptionViewModel.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 16.07.23.
//

import Foundation
import Combine


final class AccountDescriptionViewModel {
    
    private let transactionGetter: TransactionGetter
    let bankAccount: BankAccount
    
    private let transactionDeleter: TransactionDeleter
    private (set) var isTransactionWasDeleted = PassthroughSubject<Bool,Never>()
    
    var transactions: [TransactionDescription] = []
    private (set) var allTransactionsWasGetted = PassthroughSubject<Bool,Never>()
    
    
    init(transactionGetter: TransactionGetter, bankAccount: BankAccount, transactionDeleter: TransactionDeleter) {
        self.transactionGetter = transactionGetter
        self.transactionDeleter = transactionDeleter
        self.bankAccount = bankAccount
    }
    
    func getTransaction(){
        transactionGetter.getBankAccountTransaction(by: bankAccount.id) { [weak self] transactions in
            self?.transactions = transactions.reversed() // первый -> последний
            self?.allTransactionsWasGetted.send(true)
            print(transactions)
        }
    }
    
    func deleteTransaction(transaction: TransactionDescription){
        transactionDeleter.deleteTrnasaction(transaction: transaction) { [weak self] error in
            self?.isTransactionWasDeleted.send(true)
        }
    }
}
