//
//  TransactionDescriptionViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 16.07.23.
//

import UIKit
import Combine

final class TransactionDescriptionViewController: NiblessViewController {
   
    private let addTransactionCategoryViewControllerFactory: () -> AddTransactionCategoryViewController
    
    private let viewModel: TransactionDescriptionViewModel
    private let transactionValue: String
    private let transactionType: TransactionType
    private let transactionWasAddedAnimationNavigationResponder: TransactionWasAddedNavigationResponder
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
        addDelegates()
        bindViewModel()
        addTargets()
        setupAddButton()
        
        viewModel.getBankAccounts()
        viewModel.getTransactionCategories(type: transactionType)
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
    
    init(viewModel: TransactionDescriptionViewModel,transactionValue: String, transactionType: TransactionType,
         transactionWasAddedAnimationNavigationResponder: TransactionWasAddedNavigationResponder, addTransactionCategoryViewControllerFactory: @escaping () -> AddTransactionCategoryViewController) {
        self.viewModel = viewModel
        self.transactionType = transactionType
        self.transactionValue = transactionValue
        self.transactionWasAddedAnimationNavigationResponder = transactionWasAddedAnimationNavigationResponder
        self.addTransactionCategoryViewControllerFactory = addTransactionCategoryViewControllerFactory
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
        viewModel.transactionCategoriesWasGetted.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.contentView.transactionCategoryCollectionView.reloadData()
        }.store(in: &cancellable)
    }
    
    private func setupAddButton(){
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector( addButtonWasPressed))
        navigationItem.rightBarButtonItem = addButton
    }
}

extension TransactionDescriptionViewController{
    @objc private func saveTransactionButtonWasPressed(){
        guard let category = self.viewModel.selectedCategory else { return }
        guard let bankAccount = self.viewModel.selectedBankAccount else { return }
        let transaction = TransactionDescription(id: UUID().uuidString,
                                                 bankAccountId: bankAccount.id,
                                                 value: self.transactionValue,
                                                 type: self.transactionType,
                                                 categoryId: category.id,
                                                 date: Date())
        self.viewModel.createTransaction(transaction: transaction)
    }
    
    @objc private func addButtonWasPressed(){
        let addTransactionCategoryViewController = addTransactionCategoryViewControllerFactory()
        navigationController?.pushViewController(addTransactionCategoryViewController, animated: true)
    }
}

extension TransactionDescriptionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == contentView.transactionCategoryCollectionView {
           return viewModel.transactionCategories.count
        }
        return viewModel.bankAccounts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.contentView.transactionCategoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionCategoryCollectionViewCell.id, for: indexPath)
            guard let collectionCell = cell as? TransactionCategoryCollectionViewCell else { return cell }
            collectionCell.setupCell(category: viewModel.transactionCategories[indexPath.row])
            return collectionCell
        }  else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BankAccountsCollectionViewCell.id, for: indexPath)
            guard let collectionCell = cell as? BankAccountsCollectionViewCell else { return cell }
            collectionCell.setupCell(bankAccount: viewModel.bankAccounts[indexPath.row])
            return collectionCell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 170, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == contentView.transactionCategoryCollectionView {
            let selectedCategory = viewModel.transactionCategories[indexPath.row]
            viewModel.selectedCategory = selectedCategory
        }else if collectionView == contentView.bankAccountsCollectionView{
            viewModel.selectedBankAccount = viewModel.bankAccounts[indexPath.row]
        }
    }
}
