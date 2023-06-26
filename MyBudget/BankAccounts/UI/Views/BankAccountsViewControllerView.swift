//
//  BankAccountsViewControllerView.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 25.06.23.
//

import UIKit
final class BankAccountsViewControllerView: NiblessView {
    
    let totalBalanceView: BankAccountsTotalBalanceView = {
        let view = BankAccountsTotalBalanceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let addBankAccountButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .cyan
        button.setTitle("Добавить счет", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        laoutElemets()
        
        backgroundColor = .blue
    }
    
    private func laoutElemets() {
        laoutTotalBalanceView()
        laoutBankAccountButton()
    }
    
    private func laoutTotalBalanceView() {
        addSubview(totalBalanceView)
        NSLayoutConstraint.activate([
            totalBalanceView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25),
            totalBalanceView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            totalBalanceView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    private func laoutBankAccountButton() {
        addSubview(addBankAccountButton)
        NSLayoutConstraint.activate([
            addBankAccountButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -35),
            addBankAccountButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
}
