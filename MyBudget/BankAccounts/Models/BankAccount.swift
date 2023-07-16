//
//  BankAccount.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 15.07.23.
//

import Foundation

class BankAccount  {
    
    let id: String
    let name: String
    let type: BankAccountType
    let value: String
    
    init(name: String, type: BankAccountType, value: String, id: String) {
        self.id = id
        self.name = name
        self.type = type
        self.value = value
    }
}
