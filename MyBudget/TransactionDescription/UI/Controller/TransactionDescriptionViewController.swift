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
    private let transactionWasAddedAnimationNavigationResponder: TransactionWasAddedNavigationResponder
    
    var contentView: TransactionDescriptionViewControllerView {
        view as! TransactionDescriptionViewControllerView
    }
    
    override func loadView() {
        super.loadView()
        view = TransactionDescriptionViewControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDelegates()
        bindViewModel()
        
        viewModel.getBankAccounts()
        addTargets()
    }
    
    private func addDelegates(){
        contentView.transactionCategoryCollectionView.dataSource = self
        contentView.transactionCategoryCollectionView.delegate = self
        
        contentView.bankAccountsCollectionView.dataSource = self
        contentView.bankAccountsCollectionView.delegate = self
    }
    
    private func addTargets() {
        contentView.saveTransactionButton.addTarget(self, action: #selector(saveTransactionButtonWasPressed), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)){
        }
    }
    
    init(viewModel: TransactionDescriptionViewModel,transactionValue: String, transactionType: TransactionType,
         transactionWasAddedAnimationNavigationResponder: TransactionWasAddedNavigationResponder) {
        self.viewModel = viewModel
        self.transactionType = transactionType
        self.transactionValue = transactionValue
        self.transactionWasAddedAnimationNavigationResponder = transactionWasAddedAnimationNavigationResponder
        super.init()
    }
    
    private func bindViewModel(){
        viewModel.transactionWasCreated.sink { [weak self] _ in
            DispatchQueue.main.async { [weak self] in
                self?.dismiss(animated: true, completion: {
                    self?.transactionWasAddedAnimationNavigationResponder.showTransactionWasAddedNavigationResponder()
                })
            }
        }.store(in: &cancellable)
        viewModel.bankAccountsWasGetted.sink { [weak self] _ in
            DispatchQueue.main.async { [weak self] in
                self?.contentView.bankAccountsCollectionView.reloadData()
            }
        }.store(in: &cancellable)
    }
    
}

extension TransactionDescriptionViewController{
    @objc private func saveTransactionButtonWasPressed() {
        guard let category = self.viewModel.selectedCategory else { return }
        guard let bankAccount = self.viewModel.selectedBankAccount else { return }
        let transaction = TransactionDescription(id: UUID().uuidString,
                                                 bankAccountId: bankAccount.id,
                                                 value: self.transactionValue,
                                                 type: self.transactionType,
                                                 category: category,
                                                 date: Date())
        self.viewModel.createTransaction(transaction: transaction)
    }
}

extension TransactionDescriptionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == contentView.transactionCategoryCollectionView {
            switch transactionType {
                case .income: return TransactionCategory.getIncomeCategories().count
                case .expenditure: return TransactionCategory.getExpemdetureCategories().count
            }
        }
        return viewModel.bankAccounts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.contentView.transactionCategoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionDescriptionCollectionVIewCell.id, for: indexPath)
            guard let collectionCell = cell as? TransactionDescriptionCollectionVIewCell else { return cell }
            switch transactionType {
                case .income:
                    let categories = TransactionCategory.getIncomeCategories()
                    collectionCell.setupCell(category: categories[indexPath.row])
                case .expenditure:
                    let categories = TransactionCategory.getExpemdetureCategories()
                    collectionCell.setupCell(category: categories[indexPath.row])
            }
            return collectionCell
        }  else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionDescriptionCollectionViewCell2.id, for: indexPath)
            guard let collectionCell = cell as? TransactionDescriptionCollectionViewCell2 else { return cell }
            collectionCell.setupCell(bankAccount: viewModel.bankAccounts[indexPath.row])
            return collectionCell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == contentView.transactionCategoryCollectionView {
        }
        return CGSize(width: 170, height: 160)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == contentView.transactionCategoryCollectionView {
            switch transactionType {
                case .income:
                    let categories = TransactionCategory.getIncomeCategories()
                    viewModel.selectedCategory = categories[indexPath.row]
                case .expenditure:
                    let categories = TransactionCategory.getExpemdetureCategories()
                    viewModel.selectedCategory = categories[indexPath.row]
            }
        }else if collectionView == contentView.bankAccountsCollectionView{
            viewModel.selectedBankAccount = viewModel.bankAccounts[indexPath.row]
        }
    }
}
