//
//  AddTransactionCategoryViewModel.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 14.08.23.
//

import Foundation

final class AddTransactionCategoryViewModel{
    
    private let transactionCategoryCreator: TransactionCategoryCreator
    
    init(transactionCategoryCreator: TransactionCategoryCreator) {
        self.transactionCategoryCreator = transactionCategoryCreator
    }
}
