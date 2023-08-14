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
    @objc dynamic var type: String = TransactionType.income.rawValue
    @objc dynamic var categoryId: String = ""
    @objc dynamic var date: Date = Date()
    
    var typeEnum: TransactionType{
        get{
            return TransactionType(rawValue: type)!
        }
    }
    
    convenience init(id: String, bankAccountId: String, value: String, type: TransactionType, categoryId: String, date: Date) {
        self.init()
        self.id = id
        self.bankAccountId = bankAccountId
        self.type = type.rawValue
        self.value = value
        self.categoryId = categoryId
        self.date = date
    }
}
