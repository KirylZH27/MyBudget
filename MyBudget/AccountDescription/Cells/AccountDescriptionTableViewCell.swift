//
//  AccountDescriptionTableViewCell.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 17.07.23.
//

import UIKit

class AccountDescriptionTableViewCell: UITableViewCell {
    
    static let id = String(describing: AccountDescriptionTableViewCell.self)
    
    let spendingElementImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "car")
        imageView.tintColor = .brown
        return imageView
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Transport"
        label.textColor = .black
        return label
    }()
    
    let amountOfMoneyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AmericanTypewriter", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "-100 Br"
        label.textColor = .red
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutElemets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(accountDescription: TransactionDescription ){
        nameLabel.text =  accountDescription.category.rawValue
        amountOfMoneyLabel.text = accountDescription.value
        setupIconImage(category: accountDescription.category)
        setupTransactionTypeColor(type: accountDescription.type)
    }
    
    private func setupIconImage(category: TransactionCategory){
        switch category {
                
            case .trasport:
                spendingElementImageView.image = UIImage(systemName: "bus")
            case .food:
                spendingElementImageView.image = UIImage(systemName: "basket")
            case .car:
                spendingElementImageView.image = UIImage(systemName: "car")
        }
    }
    
    private func setupTransactionTypeColor(type: TransactionType){
        switch type {
            case .income:
                amountOfMoneyLabel.textColor = .green
            case .expenditure:
                amountOfMoneyLabel.textColor = .red
        }
    }
    
    private func layoutElemets() {
        layoutSpendingElementImageView()
        layoutNameLabel()
        layoutAmountOfMoneyLabel()
    }
    
    private func layoutSpendingElementImageView(){
        contentView.addSubview(spendingElementImageView)
        NSLayoutConstraint.activate([
            spendingElementImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            spendingElementImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            spendingElementImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            spendingElementImageView.widthAnchor.constraint(equalToConstant: 65)
        ])
    }
    private func layoutNameLabel(){
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: spendingElementImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            nameLabel.widthAnchor.constraint(equalToConstant: 140)
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

