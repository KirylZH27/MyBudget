//
//  BankAccountsTotalBalanceView.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 25.06.23.
//

import UIKit

final class BankAccountsTotalBalanceView: NiblessView {
    
    let balanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "185 Br"
        label.textAlignment = .center
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 20)
        label.textColor = AppColors.black.value
        return label
    }()
    
    private let totalBalanceDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Общий баланс"
        label.textAlignment = .center
        label.textColor = AppColors.black.value
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutElemets()
    }
    
    private func layoutElemets() {
        layoutBalanceLabel()
        layoutTotalBalanceDescriptionLabel()
    }
    
    private func layoutBalanceLabel() {
        addSubview(balanceLabel)
        NSLayoutConstraint.activate([
            balanceLabel.topAnchor.constraint(equalTo: topAnchor),
            balanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            balanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func layoutTotalBalanceDescriptionLabel() {
        addSubview(totalBalanceDescriptionLabel)
        NSLayoutConstraint.activate([
            totalBalanceDescriptionLabel.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 5),
            totalBalanceDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            totalBalanceDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            totalBalanceDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
