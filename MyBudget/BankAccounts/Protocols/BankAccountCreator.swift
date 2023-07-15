//
//  BankAccountCreator.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 15.07.23.
//

import Foundation

protocol BankAccountCreator {
    func createBankAccount(bankAccount: BankAccount, completion: @escaping (Error?) -> Void)
}
