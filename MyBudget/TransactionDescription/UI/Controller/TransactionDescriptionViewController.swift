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
        addDelegates()
        bindViewModel()
    }
    
    private func addDelegates(){
        contentView.transactionCategoryCollectionView.dataSource = self
        contentView.transactionCategoryCollectionView.delegate = self
        
        contentView.bankAccountsCollectionView.dataSource = self
        contentView.bankAccountsCollectionView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)){
            guard let category = self.viewModel.selectedCategory else { return }
            let transaction = TransactionDescription(id: UUID().uuidString,
                                                     bankAccountId: "4735DC2B-A07B-4347-9880-55AB19990629",
                                                     value: self.transactionValue,
                                                     type: self.transactionType,
                                                     category: category)
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

extension TransactionDescriptionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == contentView.transactionCategoryCollectionView {
            return viewModel.categories.count
        }
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.contentView.transactionCategoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionDescriptionCollectionVIewCell.id, for: indexPath)
            guard let collectionCell = cell as? TransactionDescriptionCollectionVIewCell else { return cell }
            collectionCell.setupCell(category: viewModel.categories[indexPath.row])
            return collectionCell
        }  else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionDescriptionCollectionViewCell2.id, for: indexPath)
            guard let collectionCell = cell as? TransactionDescriptionCollectionViewCell2 else { return cell }
            return collectionCell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == contentView.transactionCategoryCollectionView {
            CGSize(width: 170, height: 160)
        }
        return CGSize(width: 170, height: 160)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == contentView.transactionCategoryCollectionView {
            viewModel.selectedCategory = viewModel.categories[indexPath.row]
        }
    }
}
