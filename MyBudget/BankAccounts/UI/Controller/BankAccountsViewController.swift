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
        addDelegates()
    }
    
    private func addDelegates(){
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
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

extension BankAccountsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BankAccountsTableViewCell.id, for: indexPath)
        guard let bankAccountCell = cell as? BankAccountsTableViewCell else
        { return cell }
        return bankAccountCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

