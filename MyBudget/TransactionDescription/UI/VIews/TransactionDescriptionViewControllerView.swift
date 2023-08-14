//
//  TransactionDescriptionViewControllerView.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 16.07.23.
//

import UIKit

final class TransactionDescriptionViewControllerView: NiblessView {
    
    private let appColorGetter: AppColorGetter
    
    let expenditureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Выберите тип"
        label.textAlignment = .center
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 27)
        label.textColor = AppColors.black.value
        return label
    }()
    
    let transactionCategoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TransactionCategoryCollectionViewCell.self, forCellWithReuseIdentifier: TransactionCategoryCollectionViewCell.id)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let incomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Выберите счёт"
        label.textAlignment = .center
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 27)
        label.textColor = AppColors.black.value
        return label
    }()
    
    let bankAccountsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(BankAccountsCollectionViewCell.self, forCellWithReuseIdentifier: BankAccountsCollectionViewCell.id)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    lazy var saveTransactionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = appColorGetter.mainColor
        button.setTitle("Добавить транзакцию", for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = AppFonts.AmericanBold.value(size: 22)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        appColorGetter = UserDefaultAppColorDataSource()
        super.init(frame: frame)
        backgroundColor = AppColors.white.value
        layoutElements()
    }
    
    private func layoutElements(){
        layoutExpenditureLabel()
        layoutTransactionCategoryCollectionView()
        layoutIncomeLabel()
        layoutBankAccountsCollectionView()
        layoutSaveTransactionButton()
    }
    
    private func layoutExpenditureLabel(){
        addSubview(expenditureLabel)
        NSLayoutConstraint.activate([
            expenditureLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
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
    
    private func layoutSaveTransactionButton(){
        addSubview(saveTransactionButton)
        NSLayoutConstraint.activate([
            saveTransactionButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -28),
            saveTransactionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            saveTransactionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            saveTransactionButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}
