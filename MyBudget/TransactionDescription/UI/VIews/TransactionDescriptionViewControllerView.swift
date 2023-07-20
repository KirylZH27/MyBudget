//
//  TransactionDescriptionViewControllerView.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 16.07.23.
//

import UIKit

final class TransactionDescriptionViewControllerView: NiblessView {
    
    let expenditureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Выберите тип расхода"
        label.textAlignment = .center
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 27)
        label.textColor = .black
        return label
    }()
    
    
    let transactionCategoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TransactionDescriptionCollectionVIewCell.self, forCellWithReuseIdentifier: TransactionDescriptionCollectionVIewCell.id)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let incomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Выберите тип дохода"
        label.textAlignment = .center
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 27)
        label.textColor = .black
        return label
    }()
    
    let bankAccountsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TransactionDescriptionCollectionViewCell2.self, forCellWithReuseIdentifier: TransactionDescriptionCollectionViewCell2.id)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layoutElements()
    }
    
    private func layoutElements(){
        layoutExpenditureLabel()
        layoutTransactionCategoryCollectionView()
        layoutIncomeLabel()
        layoutBankAccountsCollectionView()
    }
    
    private func layoutExpenditureLabel(){
        addSubview(expenditureLabel)
        NSLayoutConstraint.activate([
            expenditureLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 45),
            expenditureLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func layoutTransactionCategoryCollectionView(){
        addSubview(transactionCategoryCollectionView)
        NSLayoutConstraint.activate([
            transactionCategoryCollectionView.topAnchor.constraint(equalTo: expenditureLabel.bottomAnchor, constant: 7),
            transactionCategoryCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            transactionCategoryCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            transactionCategoryCollectionView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    private func layoutIncomeLabel(){
        addSubview(incomeLabel)
        NSLayoutConstraint.activate([
            incomeLabel.topAnchor.constraint(equalTo: transactionCategoryCollectionView.bottomAnchor, constant: 55),
            incomeLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func layoutBankAccountsCollectionView(){
        addSubview(bankAccountsCollectionView)
        NSLayoutConstraint.activate([
            bankAccountsCollectionView.topAnchor.constraint(equalTo: incomeLabel.bottomAnchor, constant: 7),
            bankAccountsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bankAccountsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bankAccountsCollectionView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    
}
