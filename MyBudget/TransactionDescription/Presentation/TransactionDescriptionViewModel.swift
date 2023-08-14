//
//  TransactionDescriptionViewModel.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 16.07.23.
//

import Foundation
import Combine
final class TransactionDescriptionViewModel {
    
    var selectedCategory: TransactionCategory?
    var selectedBankAccount: BankAccount?
    
    
    private let bankAccountGetter: BankAccountGetter
    private let transactionCreator: TransactionCreator
    private let transactionCategoryGetter: TransactionCategoryGetter
    
    private (set) var transactionWasCreated = PassthroughSubject<Bool,Never>()
    private (set) var bankAccountsWasGetted = PassthroughSubject<Bool,Never>()
    private (set) var bankAccounts: [BankAccount] = []
    private (set) var transactionCategories: [TransactionCategory] = []
    private (set) var transactionCategoriesWasGetted = PassthroughSubject<Bool,Never>()
    
    
    init(bankAccountGetter: BankAccountGetter, transactionCreator: TransactionCreator, transactionCategoryGetter: TransactionCategoryGetter ) {
        self.bankAccountGetter = bankAccountGetter
        self.transactionCreator = transactionCreator
        self.transactionCategoryGetter = transactionCategoryGetter
    }
    
    func createTransaction(transaction: TransactionDescription){
        transactionCreator.createTransaction(transaction: transaction) { [weak self] _ in
            self?.transactionWasCreated.send(true)
        }
    }
    
    func getBankAccounts(){
        bankAccountGetter.getAllBankAccounts { [weak self] bankAccounts in
            self?.bankAccounts = bankAccounts
            self?.bankAccountsWasGetted.send(true)
        }
    }
    
    func getTransactionCategories(type: TransactionType){
        transactionCategoryGetter.getAllCategories(type: type) { transactionCategories in
            self.transactionCategories = transactionCategories
            self.transactionCategoriesWasGetted.send(true)
        }
    }
}
