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
    
    private (set) var totalBalanseWasCalculated = PassthroughSubject<Double,Never>()
    
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
    
    func calculateTotalBalanse(){
        let incomeTransactions = transactions.filter{ $0.type == .income }
        let expenditureTransactions = transactions.filter { $0.type == .expenditure }
        
        let incomeValues = incomeTransactions.compactMap{ Double($0.value) }
        let expenditureValues = expenditureTransactions.compactMap{ Double($0.value) }
        
        let incomeSum = incomeValues.reduce(0,+) //  reduce - складываем все элемеенты массива
        let expenditureSum = expenditureValues.reduce(0,+)
        
        let totalTransactionsBalance = incomeSum - expenditureSum
        let bankAccountValue = Double(bankAccount.value) ?? 0.0
        let totalBalance = totalTransactionsBalance + bankAccountValue
        
        self.totalBalanseWasCalculated.send(totalBalance)
    }
    
    func deleteTransaction(transaction: TransactionDescription){
        transactionDeleter.deleteTransaction(transaction: transaction) { [weak self] error in
            self?.isTransactionWasDeleted.send(true)
        }
    }
}
