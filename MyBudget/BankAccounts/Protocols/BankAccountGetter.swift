//
//  BankAccountGetter.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 15.07.23.
//

import Foundation
protocol BankAccountGetter {
    func getAllBankAccounts(completion: @escaping ([BankAccount]) -> Void)
}
