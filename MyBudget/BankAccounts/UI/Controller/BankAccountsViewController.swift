//
//  BankAccountsViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 25.06.23.
//

import UIKit
import Combine

final class BankAccountsViewController: NiblessViewController {
    
    var contentView: BankAccountsViewControllerView {
        view as! BankAccountsViewControllerView
    }
    
    private let viewModel: BankAccountViewModel
    private var cancalable = Set<AnyCancellable>()
    private let addBankAccountViewControllerFactory: () -> AddBankAccountViewController
    
    init(viewModel: BankAccountViewModel,
         addBankAccountViewControllerFactory: @escaping ()-> AddBankAccountViewController) {
        self.viewModel = viewModel
        self.addBankAccountViewControllerFactory = addBankAccountViewControllerFactory
        super.init()
    }
    override func loadView() {
        super.loadView()
        view = BankAccountsViewControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
        addDelegates()
        bindViewModel()
        
        viewModel.getAllAccounts()
    }
    
    private func addDelegates(){
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
    }
    
    private func bindViewModel(){
        viewModel.allBankesWasGetted.sink { [weak self] _ in
            self?.contentView.tableView.reloadData()
        }.store(in: &cancalable)
    }
    
    private func addTargets() {
        contentView.addBankAccountButton.addTarget(self, action: #selector(addBankAccountButtonWasPressed) , for: .touchUpInside)
    }
}

extension BankAccountsViewController {
    @objc private func addBankAccountButtonWasPressed() {
        let addBankAccountViewController = addBankAccountViewControllerFactory()
        addBankAccountViewController.onDismissBlock = { [weak self] in
            self?.viewModel.getAllAccounts()
        }
        present(addBankAccountViewController, animated: true)
    }
}

extension BankAccountsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.bankAccounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BankAccountsTableViewCell.id, for: indexPath)
        guard let bankAccountCell = cell as? BankAccountsTableViewCell else
        { return cell }
        bankAccountCell.setupCell(bankAccount: viewModel.bankAccounts[indexPath.row])
        return bankAccountCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

