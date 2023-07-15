//
//  AddBankAccountViewModel.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 15.07.23.
//

import Foundation
import Combine 

final class AddBankAccountViewModel {
    private let bankAccountCreator: BankAccountCreator
    private (set) var isBankAccountCreated = PassthroughSubject<Bool, Never>()
    
    init(bankAccountCreator: BankAccountCreator) {
        self.bankAccountCreator = bankAccountCreator
    }
    
    func createBankAccount(bankAccount: BankAccount) {
        bankAccountCreator.createBankAccount(bankAccount: bankAccount) { [weak self] error in
            self?.isBankAccountCreated.send(true)
        }
    }
}
