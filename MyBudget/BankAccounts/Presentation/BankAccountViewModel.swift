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
    
    init(bankAccountGetter: BankAccountGetter) {
        self.bankAccountGetter = bankAccountGetter
    }
    
    func getAllAccounts() {
        bankAccountGetter.getAllBankAccounts { [weak self] bankAccounts in
            self?.bankAccounts = bankAccounts
            self?.allBankesWasGetted.send(true)
        }
    }
}
