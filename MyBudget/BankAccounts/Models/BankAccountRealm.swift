//
//  BankAccountRealm.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 15.07.23.
//

import Foundation
import RealmSwift

enum BankAccountType {
    case cash
    case card
}

class BankAccountRealm: Object {
    
    @objc dynamic var name: String = ""
    dynamic var type: BankAccountType = .cash
    @objc dynamic var value: String = ""
    
    convenience init(name: String, type: BankAccountType, value: String) {
        self.init()
        self.name = name
        self.type = type
        self.value = value
    }
}
