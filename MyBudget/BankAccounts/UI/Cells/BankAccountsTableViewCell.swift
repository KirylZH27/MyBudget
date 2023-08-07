//
//  BankAccountsTableViewCell.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 1.07.23.
//

import UIKit

class BankAccountsTableViewCell: UITableViewCell {
    
    static let id = String(describing: BankAccountsTableViewCell.self)
    
    private let appColorGetter: AppColorGetter
    private let transactionGetter: TransactionGetter = TransactionRealmManager()
    
    lazy var personImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "dollarsign.arrow.circlepath")
        imageView.tintColor = appColorGetter.getMainColor()
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cash"
        label.textColor = .black
        return label
    }()
    
    let amountOfMoneyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AmericanTypewriter", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "100"
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        appColorGetter = UserDefaultAppColorDataSource()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutElemets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(bankAccount: BankAccount) {
        nameLabel.text = bankAccount.name
        calculateBankAccountBalance(with: bankAccount)
        
        switch bankAccount.type {
            case .cash:
                personImageView.image = UIImage(systemName: "bitcoinsign.circle")
            case .card:
                personImageView.image = UIImage(systemName: "creditcard")
        }
    }
    
    private func calculateBankAccountBalance(with bankAccount: BankAccount){
        transactionGetter.getBankAccountTransaction(by: bankAccount.id) { [weak self] transactions in
            let incomeTransactions =  transactions.filter{ $0.type == .income }
            let expenditureTransactions = transactions.filter { $0.type == .expenditure }
            
            let incomeValues = incomeTransactions.compactMap{ Double($0.value) }
            let expenditureValues = expenditureTransactions.compactMap{ Double($0.value) }
            
            let incomeSum = incomeValues.reduce(0,+) //  reduce - складываем все элемеенты массива
            let expenditureSum = expenditureValues.reduce(0,+)
            
            let totalTransactionBalance = incomeSum - expenditureSum
            let bankAcocuntValue = Double(bankAccount.value) ?? 0.0
            
            let totalBalance = totalTransactionBalance + bankAcocuntValue
            self?.amountOfMoneyLabel.text = String(totalBalance) 
        }
    }
    
    private func layoutElemets() {
        layoutPersonImageView()
        layoutNameLabel()
        layoutAmountOfMoneyLabel()
    }
    
    private func layoutPersonImageView(){
        contentView.addSubview(personImageView)
        NSLayoutConstraint.activate([
            personImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            personImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            personImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            personImageView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func layoutNameLabel(){
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: personImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            nameLabel.widthAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    private func layoutAmountOfMoneyLabel(){
        contentView.addSubview(amountOfMoneyLabel)
        NSLayoutConstraint.activate([
            amountOfMoneyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            amountOfMoneyLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 20),
            amountOfMoneyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            amountOfMoneyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
