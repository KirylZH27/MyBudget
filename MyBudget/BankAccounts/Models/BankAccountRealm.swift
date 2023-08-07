//
//  BankAccountRealm.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 15.07.23.
//

import Foundation
import RealmSwift

enum BankAccountType: String, CaseIterable {
    case cash = "Наличные"
    case card = "Карта"
}

class BankAccountRealm: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var type: String = BankAccountType.cash.rawValue
    @objc dynamic var value: String = ""
    
    var typeEnum: BankAccountType{
        get{
            return BankAccountType(rawValue: type)!
        }
    }
    
    convenience init(name: String, type: BankAccountType, value: String, id: String) {
        self.init()
        self.id = id
        self.name = name
        self.type = type.rawValue
        self.value = value
    }
}
