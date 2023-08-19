//
//  TransactionDescriptionCollectionVIewCell.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 17.07.23.
//

import UIKit

final class TransactionCategoryCollectionViewCell: UICollectionViewCell {
    
    static let id = String(describing: TransactionCategoryCollectionViewCell.self)
    
    override var isSelected: Bool {
        didSet {
            spendingElementImageView.tintColor = isSelected ? .green : AppColors.black.value
        }
    }
    
    let spendingElementImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "car")
        imageView.layer.cornerRadius = 12
        imageView.tintColor = AppColors.black.value
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Транспорт"
        label.textAlignment = .center
        label.font = UIFont(name: "AmericanTypewriter", size: 20)
        label.textColor = AppColors.black.value
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
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
        setupIconImage(imageData: category.imageData)
        nameLabel.text = category.name
        contentView.backgroundColor = AppColors.white.value
        contentView.layer.cornerRadius = 15
    }
    
    private func setupIconImage(imageData: Data){
        let image = UIImage(data: imageData)
        spendingElementImageView.image = image?.withRenderingMode(.alwaysTemplate)
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
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
}

