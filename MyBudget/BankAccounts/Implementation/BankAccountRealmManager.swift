//
//  BankAccountRealmManager.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 15.07.23.
//

import Foundation
import RealmSwift

final class BankAccountRealmManager: BankAccountCreator, BankAccountGetter {
   
    private var realm: Realm = {
            var config = Realm.Configuration(
                schemaVersion: 1,
                migrationBlock: { migration, oldSchemaVersion in
                    if (oldSchemaVersion < 1) {}
                })
            
            config.deleteRealmIfMigrationNeeded = true
            Realm.Configuration.defaultConfiguration = config
            
            return try! Realm()
        }()
    
    func createBankAccount(bankAccount: BankAccount, completion: @escaping (Error?) -> Void) {
        let bankAccountRealm = BankAccountRealm(name: bankAccount.name, type: bankAccount.type, value: bankAccount.value, id: UUID().uuidString)
        realm.writeAsync { [weak self] in
            self?.realm.add(bankAccountRealm)
        } onComplete: { error in
            completion(error)
        }
    }
    
    func getAllBankAccounts(completion: @escaping ([BankAccount]) -> Void) {
        let bankAccountsRealm = Array(realm.objects(BankAccountRealm.self))
        let bankAccounts = bankAccountsRealm.map { BankAccount(name: $0.name, type: $0.type, value: $0.value, id: $0.id) }
        completion(bankAccounts)
    }
    
    
    
}