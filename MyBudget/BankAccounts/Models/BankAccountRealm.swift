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
    dynamic var type: BankAccountType = .cash
    @objc dynamic var value: String = ""
    
    convenience init(name: String, type: BankAccountType, value: String, id: String) {
        self.init()
        self.id = id
        self.name = name
        self.type = type
        self.value = value
    }
}
