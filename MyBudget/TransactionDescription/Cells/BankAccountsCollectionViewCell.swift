//
//  TransactionDescriptionCollectionViewCell2.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 17.07.23.
//

import UIKit

final class BankAccountsCollectionViewCell: UICollectionViewCell {
    
    static let id = String(describing: BankAccountsCollectionViewCell.self)
    
    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ? .green : .brown
        }
    }
    
    let spendingElementImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "case")
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Зарплата"
        label.textAlignment = .center
        label.font = UIFont(name: "AmericanTypewriter", size: 20)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutElemets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutElemets() {
        layoutSpendingElementImageView()
        layoutNameLabel()
    }
    
    func setupCell(bankAccount: BankAccount){
        nameLabel.text = bankAccount.name
        contentView.backgroundColor = .brown
        contentView.layer.cornerRadius = 15
    }
    
    private func layoutSpendingElementImageView(){
        contentView.addSubview(spendingElementImageView)
        NSLayoutConstraint.activate([
            spendingElementImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            spendingElementImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            spendingElementImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
            spendingElementImageView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func layoutNameLabel() {
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: spendingElementImageView.bottomAnchor, constant: 5),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}


