//
//  BankAccountsTableViewCell.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 1.07.23.
//

import UIKit

class BankAccountsTableViewCell: UITableViewCell {
    
    static let id = String(describing: BankAccountsTableViewCell.self)
    
    let personImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "dollarsign.arrow.circlepath")
        imageView.tintColor = .orange
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutElemets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func layoutElemets() {
        layoutPersonImageView()
        layoutNameLabel()
    }
    
    private func layoutPersonImageView(){
        contentView.addSubview(personImageView)
        NSLayoutConstraint.activate([
            personImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            personImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
     //       personImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            personImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
         // personImageView.heightAnchor.constraint(equalToConstant: 40),
            personImageView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func layoutNameLabel(){
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: personImageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
}
