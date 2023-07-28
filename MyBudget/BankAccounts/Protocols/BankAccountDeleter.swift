//
//  BankAccountDeleter.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 18.07.23.
//

import Foundation

protocol BankAccountDeleter {
    func deleteBankAccount(bankAccount: BankAccount, completion: @escaping (Error?) -> Void)
}

