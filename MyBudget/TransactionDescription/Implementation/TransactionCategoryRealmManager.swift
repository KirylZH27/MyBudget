//
//  TransactionCategoryRealmManager.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 13.08.23.
//

import Foundation
import RealmSwift

final class TransactionCategoryRealmManager: TransactionCategoryCreator, TransactionCategoryGetter {
    
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
    
    
    func createCategory(category: TransactionCategory, completion: @escaping (Error?) -> Void) {
        let realmCategory = TransactionCategoryRealm(id: category.id, name: category.name, imageData: category.imageData, type: category.type.rawValue)
        
        realm.writeAsync { [weak self] in
            self?.realm.add(realmCategory)
        }onComplete: { error in
            completion(error)
        }
    }
    
    func getAllCategories(type: TransactionType? = nil, completion: @escaping ([TransactionCategory]) -> Void) {
        let categoriesRealmArray = Array(realm.objects(TransactionCategoryRealm.self))
        let transanctionCategory = categoriesRealmArray.map {
            TransactionCategory(id: $0.id, name: $0.name, imageData: $0.imageData, type: $0.typeEnum)}
        if type == nil{
            completion(transanctionCategory)
        } else {
           let filteredTransactionCategory = transanctionCategory.filter { $0.type == type }
            completion(filteredTransactionCategory)
        }
    }

    func getCategory(by id: String, completion: @escaping (TransactionCategory) -> Void) {
        let categoriesRealmArray = Array(realm.objects(TransactionCategoryRealm.self))
        guard let filteredCategoriesRealm = (categoriesRealmArray.first { $0.id == id }) else { return }
        let transactionCategory = TransactionCategory(id: filteredCategoriesRealm.id,
                                                      name: filteredCategoriesRealm.name,
                                                      imageData: filteredCategoriesRealm.imageData,
                                                      type: filteredCategoriesRealm.typeEnum)
        completion(transactionCategory)
    }
    
}
