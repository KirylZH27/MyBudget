//
//  AccountDescriptionTableViewCell.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 17.07.23.
//

import UIKit

class AccountDescriptionTableViewCell: UITableViewCell {
    
    static let id = String(describing: AccountDescriptionTableViewCell.self)
    
    private let transactionCategoryGetter: TransactionCategoryGetter
    
    let spendingElementImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "car")
        imageView.image = image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = AppColors.black.value
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Transport"
        label.textColor = AppColors.black.value
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
        label.textColor = AppColors.black.value
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.transactionCategoryGetter = TransactionCategoryRealmManager()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutElemets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(accountDescription: TransactionDescription ){
        getCurrentCategory(by: accountDescription.categoryId)
        amountOfMoneyLabel.text = accountDescription.value
        setupTransactionTypeColor(type: accountDescription.type)
        setupDateLabel(date: accountDescription.date)
    }
    
    private func getCurrentCategory(by id: String){
        transactionCategoryGetter.getCategory(by: id) { transactionCategory in
            self.setupIconImage(imageData: transactionCategory.imageData)
            self.nameLabel.text = transactionCategory.name
        }
    }
    
    private func setupIconImage(imageData: Data){
        let image = UIImage(data: imageData)
        spendingElementImageView.image = image?.withRenderingMode(.alwaysOriginal)
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
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 33),
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

