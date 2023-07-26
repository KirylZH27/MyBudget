//
//  AccountDescriptionTableViewCell.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 17.07.23.
//

import UIKit
import Charts

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
    
   private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AmericanTypewriter", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "121"
        label.textColor = .black
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
        setupDateLabel(date: accountDescription.date)
    }
    
    private func setupIconImage(category: TransactionCategory){
        switch category {
            case .sallary:
                spendingElementImageView.image = UIImage(systemName: "bitcoinsign")
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
    
    private func setupDateLabel(date: Date){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        let prettyDateString = dateFormatter.string(from: date)
        dateLabel.text = prettyDateString
    }
    
    private func layoutElemets() {
        layoutSpendingElementImageView()
        layoutNameLabel()
        layoutAmountOfMoneyLabel()
        layoutDateLabel()
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
            nameLabel.widthAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    private func layoutAmountOfMoneyLabel(){
        contentView.addSubview(amountOfMoneyLabel)
        NSLayoutConstraint.activate([
            amountOfMoneyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            amountOfMoneyLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 20),
            amountOfMoneyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        ])
    }
    
    private func layoutDateLabel(){
        contentView.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dateLabel.topAnchor.constraint(equalTo: amountOfMoneyLabel.bottomAnchor, constant: 10),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}

