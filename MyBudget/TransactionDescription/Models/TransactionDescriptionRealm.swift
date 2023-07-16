//
//  TransactionDescriptionRealm.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 16.07.23.
//

import Foundation
import RealmSwift

class TransactionDescriptionRealm: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var bankAccountId: String = ""
    @objc dynamic var value: String = ""
    dynamic var type: TransactionType = .expenditure
    dynamic var category: TransactionCategory = .car
    
    
    convenience init(id: String, bankAccountId: String, value: String, type: TransactionType, category: TransactionCategory) {
        self.init()
        self.id = id
        self.bankAccountId = bankAccountId
        self.type = type
        self.value = value
        self.category = category
    }
}
