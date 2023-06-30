//
//  RealmManager.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 30.06.23.
//

import Foundation
import RealmSwift

class RealmManager {
    private let realm = try! Realm()
    static let shared = RealmManager()
    private init(){}
    
    func saveUser(user: UserModelRealm){
        try? realm.write({
            realm.add(user)
        })
    }
    
    func showUser() -> [UserModelRealm]{
        return Array(realm.objects(UserModelRealm.self))
    }
    
    func deleteUser(user: UserModelRealm){
        try? realm.write({
            realm.delete(user)
        })
    }
}
