//
//  AccountDescriptionViewModel.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 16.07.23.
//

import Foundation


final class AccountDescriptionViewModel {
    
    private let transactionGetter: TransactionGetter
    let bankAccount: BankAccount
    
    init(transactionGetter: TransactionGetter, bankAccount: BankAccount) {
        self.transactionGetter = transactionGetter
        self.bankAccount = bankAccount
    }
    
    func getTransaction(){
        transactionGetter.getBankAccountTransaction(by: bankAccount.id) { [weak self] transactions in
            print(transactions)
        }
    }
}
