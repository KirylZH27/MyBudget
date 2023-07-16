//
//  TransactionDescriptionViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 16.07.23.
//

import UIKit

final class TransactionDescriptionViewController: NiblessViewController {
   
    private let viewModel: TransactionDescriptionViewModel
    private let transactionValue: String
    private let transactionType: TransactionType
    
    var contentView: TransactionDescriptionViewControllerView {
        view as! TransactionDescriptionViewControllerView
    }
    
    override func loadView() {
        super.loadView()
        view = TransactionDescriptionViewControllerView()
    }
    
    init(viewModel: TransactionDescriptionViewModel,transactionValue: String, transactionType: TransactionType) {
        self.viewModel = viewModel
        self.transactionType = transactionType
        self.transactionValue = transactionValue
        super.init()
    }
}
