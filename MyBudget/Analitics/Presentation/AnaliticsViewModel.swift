//
//  AnaliticsViewModel.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 26.07.23.
//

import Foundation

final class AnaliticsViewModel {
    
    private let transactionGetter: TransactionGetter
    
    init(transactionGetter: TransactionGetter) {
        self.transactionGetter = transactionGetter
    }
    
}
