//
//  BankAccountViewModel.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 15.07.23.
//

import Foundation
import Combine

final class BankAccountViewModel {
    
    private let bankAccountGetter: BankAccountGetter
    var bankAccounts: [BankAccount] = []
    private (set) var allBankesWasGetted = PassthroughSubject<Bool,Never>()
    
    private let transactionGetter: TransactionGetter
    private (set) var totalBalanceWasGetted = PassthroughSubject<Double,Never>()
    
    private let bankAccountDeleter: BankAccountDeleter
    private (set) var isBankAccountWasDeleted = PassthroughSubject<Bool,Never>()
    
    init(bankAccountGetter: BankAccountGetter, bankAccountDeleter: BankAccountDeleter, transactionGetter: TransactionGetter) {
        self.bankAccountGetter = bankAccountGetter
        self.transactionGetter = transactionGetter
        self.bankAccountDeleter = bankAccountDeleter
    }
    
    func getAllAccounts() {
        bankAccountGetter.getAllBankAccounts { [weak self] bankAccounts in
            self?.bankAccounts = bankAccounts
            self?.getAllTransactions()
            self?.allBankesWasGetted.send(true)
        }
    }
    
    func recalculateTotalBalance(){
        getAllTransactions()
    }
    
    private func getAllTransactions(){
        transactionGetter.getAllTransactions { [weak self] transactions in
            self?.calculateTotalBalance(with: transactions)
        }
    }
    
    private func calculateTotalBalance(with transactions: [TransactionDescription]) {
        let bankAccountIds = bankAccounts.map { $0.id }
        
        // MARK: Got all account ids to display all transactions for these accounts
        
        let transactionFilter = transactions.filter {bankAccountIds.contains($0.bankAccountId)}
        
        let incomeTransactions =  transactionFilter.filter{ $0.type == .income }
        let expenditureTransactions = transactionFilter.filter { $0.type == .expenditure }
        
        let incomeValues = incomeTransactions.compactMap{ Double($0.value) }
        let expenditureValues = expenditureTransactions.compactMap{ Double($0.value) }
        
        let incomeSum = incomeValues.reduce(0,+)
        let expenditureSum = expenditureValues.reduce(0,+)
        
        let totalTransactionBalance = incomeSum - expenditureSum
        
        let bankAccountsValues = bankAccounts.compactMap{Double($0.value)}
        let totalBankAccountValues = bankAccountsValues.reduce(0,+)
        
        let totalBalance = totalTransactionBalance + totalBankAccountValues
        
        totalBalanceWasGetted.send(totalBalance)
    }
    
    func deleteBankAccount(bankAccount: BankAccount){
        bankAccountDeleter.deleteBankAccount(bankAccount: bankAccount) { [weak self]  error in
            self?.isBankAccountWasDeleted.send(true)
        }
    }
}
