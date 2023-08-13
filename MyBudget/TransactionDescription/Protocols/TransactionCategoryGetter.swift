//
//  TransactionCategoryGetter.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 13.08.23.
//

import Foundation
protocol TransactionCategoryGetter {
    func getAllCategories(completion: @escaping ([TransactionCategory]) -> Void )
    func getCategory(by id: String, completion: @escaping (TransactionCategory) -> Void)
}
