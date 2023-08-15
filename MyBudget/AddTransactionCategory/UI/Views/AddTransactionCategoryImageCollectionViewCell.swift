//
//  AddTransactionCategoryImageCollectionVIewCell.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 14.08.23.
//

import UIKit

final class AddTransactionCategoryImageCollectionViewCell: UICollectionViewCell{
    
    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ? .green : AppColors.white.value
        }
    }
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = AppColors.white.value
        layoutIconImageView()
        setupBorder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(imageName: String){
        let image = UIImage(named: imageName)
        iconImageView.image = image
    }
    
    private func setupBorder(){
        layer.cornerRadius = 25
        layer.borderWidth = 1
        layer.borderColor = AppColors.black.value.cgColor
        clipsToBounds = true
    }
    
    private func layoutIconImageView(){
        contentView.addSubview(iconImageView)
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            iconImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
