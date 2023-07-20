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
    
    var transactions: [TransactionDescription] = []
    private (set) var allTransactionsWasGetted = PassthroughSubject<Bool,Never>()
    
    
    init(transactionGetter: TransactionGetter, bankAccount: BankAccount) {
        self.transactionGetter = transactionGetter
        self.bankAccount = bankAccount
    }
    
    func getTransaction(){
        transactionGetter.getBankAccountTransaction(by: bankAccount.id) { [weak self] transactions in
            self?.transactions = transactions
            self?.allTransactionsWasGetted.send(true)
            print(transactions)
        }
    }
}
