//
//  BankAccountViewModel.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 15.07.23.
//

import Foundation

final class BankAccountViewModel {
    private let bankAccountGetter: BankAccountGetter
    var bankAccounts: [BankAccount] = []
    
    init(bankAccountGetter: BankAccountGetter) {
        self.bankAccountGetter = bankAccountGetter
    }
    
    func getAllAccounts() {
        bankAccountGetter.getAllBankAccounts { [weak self] bankAccounts in
            
        }
    }
}
