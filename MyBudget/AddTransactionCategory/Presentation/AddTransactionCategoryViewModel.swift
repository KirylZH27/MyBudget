//
//  AddTransactionCategoryViewModel.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 14.08.23.
//

import Foundation
import Combine

final class AddTransactionCategoryViewModel{
    
    var imageNames: [String] = ["restaurant", "shopping", "salary", "sport","vacation", "present", "otherExpenses", "lottery", "investment", "house", "hospital", "fuel", "entertainment", "education", "child", "burger", "animal"]
    var selectedImageName: String?
    var selectedTransactionType: TransactionType = .expenditure
    
    private (set) var transactionCategoryWasCreated = PassthroughSubject<Bool,Never>()
    
    private let transactionCategoryCreator: TransactionCategoryCreator
    
    init(transactionCategoryCreator: TransactionCategoryCreator) {
        self.transactionCategoryCreator = transactionCategoryCreator
    }
    
    func createTransactionCategory(name: String, imageData: Data){
        let category = TransactionCategory(id: UUID().uuidString,
                                           name: name,
                                           imageData: imageData,
                                           type: selectedTransactionType)
        transactionCategoryCreator.createCategory(category: category) { error in
            guard error == nil else { return }
            self.transactionCategoryWasCreated.send(true)
        }
    }
}
