//
//  BankAccountsViewControllerView.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 25.06.23.
//

import UIKit

final class BankAccountsViewControllerView: NiblessView {
    
    private let appColorGetter: AppColorGetter
    
    let totalBalanceView: BankAccountsTotalBalanceView = {
        let view = BankAccountsTotalBalanceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var addBankAccountButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = appColorGetter.mainColor
        button.setTitle("Добавить счет", for: .normal)
        button.layer.cornerRadius = 12
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(BankAccountsTableViewCell.self, forCellReuseIdentifier: BankAccountsTableViewCell.id)
        return tableView
    }()
    
    override init(frame: CGRect) {
        appColorGetter = UserDefaultAppColorDataSource()
        super.init(frame: frame)
        
        laoutElemets()
        backgroundColor = AppColors.white.value
    }
    
    private func laoutElemets() {
        laoutTotalBalanceView()
        laoutBankAccountButton()
        laoutBankAccountTableView()
    }
    
    private func laoutTotalBalanceView() {
        addSubview(totalBalanceView)
        NSLayoutConstraint.activate([
            totalBalanceView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25),
            totalBalanceView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            totalBalanceView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    private func laoutBankAccountTableView() {
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: totalBalanceView.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: addBankAccountButton.topAnchor, constant: -16)
        ])
    }
    
    private func laoutBankAccountButton() {
        addSubview(addBankAccountButton)
        NSLayoutConstraint.activate([
            addBankAccountButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -35),
            addBankAccountButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addBankAccountButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}
