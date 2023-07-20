//
//  TransactionDescriptionCollectionVIewCell.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 17.07.23.
//

import UIKit

final class TransactionDescriptionCollectionVIewCell: UICollectionViewCell {
    
    static let id = String(describing: TransactionDescriptionCollectionVIewCell.self)
    
    
    let spendingElementImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "car")
        imageView.tintColor = .white
        imageView.backgroundColor = .brown
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Транспорт"
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
    
    func setupCell(category: TransactionCategory){
        setupIconImage(category: category)
        nameLabel.text = category.rawValue
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
    
    private func layoutSpendingElementImageView(){
        contentView.addSubview(spendingElementImageView)
        NSLayoutConstraint.activate([
            spendingElementImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            spendingElementImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            spendingElementImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
           //spendingElementImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
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

