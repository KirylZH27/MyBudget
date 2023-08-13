//
//  TransactionCategory.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 13.08.23.
//

import Foundation
import RealmSwift

final class TransactionCategoryRealm: Object{
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var imageData: Data = Data()
    @objc dynamic var type: String = ""
    
    var typeEnum: TransactionType{
        get{
            return TransactionType(rawValue: type)!
        }
    }
    
    convenience init(id: String, name: String, imageData: Data, type: String) {
        self.init()
        self.id = id
        self.name = name
        self.imageData = imageData
        self.type = type
    }
}
