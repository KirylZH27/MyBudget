//
//  BankAccountsViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 25.06.23.
//

import UIKit
final class BankAccountsViewController: NiblessViewController {
    var contentView: BankAccountsViewControllerView {
        view as! BankAccountsViewControllerView
    }
    override func loadView() {
        super.loadView()
        view = BankAccountsViewControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }
    
    
    private func addTargets() {
        contentView.addBankAccountButton.addTarget(self, action: #selector(addBankAccountButtonWasPressed) , for: .touchUpInside)
    }
}

extension BankAccountsViewController {
    @objc private func addBankAccountButtonWasPressed() {
        print("Добавить")
    }
}
