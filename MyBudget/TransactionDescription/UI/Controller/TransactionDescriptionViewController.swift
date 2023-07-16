//
//  TransactionDescriptionViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 16.07.23.
//

import UIKit
import Combine

final class TransactionDescriptionViewController: NiblessViewController {
   
    private let viewModel: TransactionDescriptionViewModel
    private let transactionValue: String
    private let transactionType: TransactionType
    private var cancellable = Set<AnyCancellable>()
    
    var contentView: TransactionDescriptionViewControllerView {
        view as! TransactionDescriptionViewControllerView
    }
    
    override func loadView() {
        super.loadView()
        view = TransactionDescriptionViewControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)){
            let transaction = TransactionDescription(id: UUID().uuidString,
                                                     bankAccountId: "5E4F8996-1F64-4990-BEFD-D8E7B352F5B5",
                                                     value: self.transactionValue,
                                                     type: self.transactionType,
                                                     category: .car)
            self.viewModel.createTransaction(transaction: transaction)
        }
    }
    
    init(viewModel: TransactionDescriptionViewModel,transactionValue: String, transactionType: TransactionType) {
        self.viewModel = viewModel
        self.transactionType = transactionType
        self.transactionValue = transactionValue
        super.init()
    }
    
    private func bindViewModel(){
        viewModel.transactionWasCreated.sink { [weak self] _ in
            DispatchQueue.main.async { [weak self] in
                self?.dismiss(animated: true)
            }
        }.store(in: &cancellable)
    }
}
