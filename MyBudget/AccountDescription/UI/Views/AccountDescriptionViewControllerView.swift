//
//  AccountDescriptionViewControllerView.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 16.07.23.
//

import UIKit
final class AccountDescriptionViewControllerView: NiblessView {
    
    let balanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "5 Br"
        label.textAlignment = .center
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 24)
        label.textColor = .black
        return label
    }()
    
    private let currentBalanceDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Текущий баланс"
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AccountDescriptionTableViewCell.self, forCellReuseIdentifier: AccountDescriptionTableViewCell.id)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        layoutElemets()
    }
    
    private func layoutElemets() {
        layoutBalanceLabel()
        layoutCurrentBalanceDescriptionLabel()
        layoutAccountDescriptionTableView()
    }
    
    private func layoutBalanceLabel() {
        addSubview(balanceLabel)
        NSLayoutConstraint.activate([
            balanceLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            balanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            balanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    private func layoutCurrentBalanceDescriptionLabel() {
        addSubview(currentBalanceDescriptionLabel)
        NSLayoutConstraint.activate([
            currentBalanceDescriptionLabel.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 5),
            currentBalanceDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            currentBalanceDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    private func layoutAccountDescriptionTableView() {
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: currentBalanceDescriptionLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}
