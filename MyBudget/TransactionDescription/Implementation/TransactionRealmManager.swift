//
//  TransactionRealmManager.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 16.07.23.
//

import Foundation
import RealmSwift

final class TransactionRealmManager: TransactionCreator, TransactionGetter {
   
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
    
    func createTransaction(transaction: TransactionDescription, completion: @escaping (Error?) -> Void) {
        let transactionRealm = TransactionDescriptionRealm(id: transaction.id,
                                                           bankAccountId: transaction.bankAccountId,
                                                           value: transaction.value,
                                                           type: transaction.type,
                                                           category: transaction.category)
        realm.writeAsync { [weak self] in
            self?.realm.add(transactionRealm)
        } onComplete: { error in
            completion(error)
        }
    }
    
    func getBankAccountTransaction(by id: String, completion: @escaping ([TransactionDescription]) -> Void) {
        let transactionsRealmArray = Array(realm.objects(TransactionDescriptionRealm.self))
        let filteredTransactionRealm = transactionsRealmArray.filter { $0.bankAccountId == id }
        let transactionDesctiptions = filteredTransactionRealm.map { TransactionDescription(id: $0.id, bankAccountId: $0.bankAccountId, value: $0.value, type: $0.typeEnum, category: $0.categoryEnum)}
     completion(transactionDesctiptions)
    }
    
}
