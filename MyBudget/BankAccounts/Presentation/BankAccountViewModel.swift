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
    
    // ----------------------------------------------------------- - DEL
    private let bankAccountDeleter: BankAccountDeleter
    private (set) var isBankAccountWasDeleted = PassthroughSubject<Bool,Never>()
    // добавил еще в инициализатор bankAccountDeleter
    // -----------------------------------------------------------
    
    init(bankAccountGetter: BankAccountGetter, bankAccountDeleter: BankAccountDeleter) {
        self.bankAccountGetter = bankAccountGetter
        
        // ----------------------------------------------------------- - DEL
        self.bankAccountDeleter = bankAccountDeleter
        // -----------------------------------------------------------
    }
    
    func getAllAccounts() {
        bankAccountGetter.getAllBankAccounts { [weak self] bankAccounts in
            self?.bankAccounts = bankAccounts
            self?.allBankesWasGetted.send(true)
        }
    }
    
    // ----------------------------------------------------------- - DEL
    func deleteBankAccount(bankAccount: BankAccount){
        bankAccountDeleter.deleteBankAccount(bankAccount: bankAccount) { [weak self]  error in
            self?.isBankAccountWasDeleted.send(true)
        }
    }
    // -----------------------------------------------------------
}
