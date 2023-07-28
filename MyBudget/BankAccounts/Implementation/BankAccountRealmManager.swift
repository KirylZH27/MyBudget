//
//  BankAccountRealmManager.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 15.07.23.
//

import Foundation
import RealmSwift

final class BankAccountRealmManager: BankAccountCreator, BankAccountGetter, BankAccountDeleter {
    
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
        let bankAccountRealm = BankAccountRealm(name: bankAccount.name, type: bankAccount.type, value: bankAccount.value, id: bankAccount.id)
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
    
    func deleteBankAccount(bankAccount: BankAccount, completion: @escaping (Error?) -> Void) {
        
        let bankAccountsRealm = Array(realm.objects(BankAccountRealm.self))
        guard let bankAccountRealm = bankAccountsRealm.filter({ $0.id == bankAccount.id }).first else { return }
        realm.writeAsync { [weak self] in
            self?.realm.delete(bankAccountRealm)
        } onComplete: { error in
            self.deleteBankAcocuntTransactions(bankAccountId: bankAccount.id, completion: completion)
        }
    }
    
    private func deleteBankAcocuntTransactions(bankAccountId: String ,completion: @escaping (Error?) -> Void){
        DispatchQueue.main.async {
            let tranasctionsRealm = Array(self.realm.objects(TransactionDescriptionRealm.self))
            let transactionFilter = tranasctionsRealm.filter{ $0.bankAccountId == bankAccountId}
            self.realm.writeAsync { [weak self] in
                self?.realm.delete(transactionFilter)
            } onComplete: { error in
                completion(error)
            }
        }
    }
}
