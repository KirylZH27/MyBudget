//
//  UserModelRealm.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 30.06.23.
//

import Foundation
import RealmSwift

class UserModelRealm: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var imageURLString: String = ""
    
    convenience init(name: String, imageURLString: String) {
        self.init()
        self.name = name
        self.imageURLString = imageURLString
    }
}
